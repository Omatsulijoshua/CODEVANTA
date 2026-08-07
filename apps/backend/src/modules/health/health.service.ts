import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../core/prisma/prisma.service';
import { RedisService } from '../../core/redis/redis.service';

@Injectable()
export class HealthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly redis: RedisService,
  ) {}

  async checkHealth() {
    let dbStatus = 'down';
    try {
      await this.prisma.$queryRaw`SELECT 1`;
      dbStatus = 'up';
    } catch {
      dbStatus = 'down';
    }

    const redisPing = await this.redis.ping();
    const redisStatus = redisPing === 'PONG' ? 'up' : 'down';

    return {
      status: 'ok',
      service: 'codevanta-api',
      timestamp: new Date().toISOString(),
      database: dbStatus,
      redis: redisStatus,
    };
  }
}
