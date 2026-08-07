import { IsEmail, IsNotEmpty, IsString, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class RegisterDto {
  @ApiProperty({ example: 'developer@codevanta.app' })
  @IsEmail()
  email: string;

  @ApiProperty({ example: 'SecretPass123!' })
  @IsString()
  @MinLength(8)
  password: string;

  @ApiProperty({ example: 'Alex Dev' })
  @IsString()
  @IsNotEmpty()
  fullName: string;
}
