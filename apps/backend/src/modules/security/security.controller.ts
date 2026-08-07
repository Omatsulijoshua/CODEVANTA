import { Controller, Post, Body } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { SecurityService } from './security.service';

@ApiTags('Security')
@Controller('api/v1/security')
export class SecurityController {
  constructor(private readonly securityService: SecurityService) {}

  @Post('sanitize-prompt')
  @ApiOperation({ summary: 'Sanitize AI prompt against token leaks and prompt injection' })
  async sanitizePrompt(@Body('prompt') prompt: string) {
    return this.securityService.sanitizePrompt(prompt || '');
  }
}
