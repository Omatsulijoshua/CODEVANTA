import { Injectable, BadRequestException, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from '../../core/prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { RefreshTokenDto } from './dto/refresh-token.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async register(dto: RegisterDto) {
    const existing = await this.prisma.user.findUnique({
      where: { email: dto.email.toLowerCase() },
    });

    if (existing) {
      throw new BadRequestException('User with this email already exists.');
    }

    const passwordHash = await bcrypt.hash(dto.password, 10);

    const user = await this.prisma.user.create({
      data: {
        email: dto.email.toLowerCase(),
        passwordHash,
        fullName: dto.fullName,
        profile: {
          create: {
            theme: 'codevanta-dark',
          },
        },
      },
      include: { profile: true },
    });

    await this.prisma.auditLog.create({
      data: {
        userId: user.id,
        action: 'USER_REGISTER',
        resource: 'User',
      },
    });

    return this.generateTokens(user.id, user.email);
  }

  async login(dto: LoginDto) {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email.toLowerCase() },
      include: { profile: true },
    });

    if (!user || !user.passwordHash) {
      throw new UnauthorizedException('Invalid email or password.');
    }

    const isValid = await bcrypt.compare(dto.password, user.passwordHash);
    if (!isValid) {
      throw new UnauthorizedException('Invalid email or password.');
    }

    if (dto.deviceName) {
      await this.prisma.device.create({
        data: {
          userId: user.id,
          deviceName: dto.deviceName,
          deviceOs: dto.deviceOs || 'iOS',
        },
      });
    }

    await this.prisma.auditLog.create({
      data: {
        userId: user.id,
        action: 'USER_LOGIN',
        resource: 'User',
      },
    });

    return this.generateTokens(user.id, user.email);
  }

  async refreshToken(dto: RefreshTokenDto) {
    const session = await this.prisma.session.findUnique({
      where: { refreshToken: dto.refreshToken },
      include: { user: true },
    });

    if (!session || session.expiresAt < new Date()) {
      throw new UnauthorizedException('Refresh token expired or invalid.');
    }

    return this.generateTokens(session.userId, session.user.email, session.id);
  }

  async logout(userId: string, token: string) {
    await this.prisma.session.deleteMany({
      where: { userId, token },
    });
  }

  async logoutAll(userId: string) {
    await this.prisma.session.deleteMany({
      where: { userId },
    });
  }

  private async generateTokens(userId: string, email: string, existingSessionId?: string) {
    const payload = { sub: userId, email };
    const accessToken = this.jwtService.sign(payload, { expiresIn: '15m' });
    const refreshToken = this.jwtService.sign(payload, { expiresIn: '7d' });

    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 7);

    if (existingSessionId) {
      await this.prisma.session.update({
        where: { id: existingSessionId },
        data: { token: accessToken, refreshToken, expiresAt },
      });
    } else {
      await this.prisma.session.create({
        data: {
          userId,
          token: accessToken,
          refreshToken,
          expiresAt,
        },
      });
    }

    return {
      accessToken,
      refreshToken,
      user: { id: userId, email },
    };
  }
}
