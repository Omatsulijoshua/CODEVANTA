import { Controller, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { AiGatewayService } from './ai-gateway.service';
import { AgentExecutionRequest } from './interfaces/agent-protocol.interface';

@ApiTags('AI Gateway')
@Controller('api/v1/ai-gateway')
export class AiGatewayController {
  constructor(private readonly aiGatewayService: AiGatewayService) {}

  @Post('execute')
  @ApiOperation({ summary: 'Dispatch unified AI agent execution to requested provider' })
  async executeAgent(@Body() request: AgentExecutionRequest) {
    return this.aiGatewayService.executeAgent(request);
  }
}
