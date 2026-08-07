import { IsEmail, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class LoginDto {
  @ApiProperty({ example: 'developer@codevanta.app' })
  @IsEmail()
  email: string;

  @ApiProperty({ example: 'SecretPass123!' })
  @IsString()
  password: string;

  @ApiProperty({ example: 'iPhone 15 Pro' })
  @IsString()
  deviceName?: string;

  @ApiProperty({ example: 'iOS' })
  @IsString()
  deviceOs?: string;
}
