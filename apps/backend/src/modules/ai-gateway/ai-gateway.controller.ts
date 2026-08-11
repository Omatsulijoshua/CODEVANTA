import { Controller, Post, Get, Body } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { AiGatewayService } from './ai-gateway.service';
import { AgentExecutionRequest } from './interfaces/agent-protocol.interface';

@ApiTags('AI Gateway')
@Controller('api/v1/ai-gateway')
export class AiGatewayController {
  constructor(private readonly aiGatewayService: AiGatewayService) {}

  @Post('execute')
  @ApiOperation({ summary: 'Dispatch unified AI agent execution to requested provider with multi-key rotation & fallback' })
  async executeAgent(@Body() request: AgentExecutionRequest) {
    return this.aiGatewayService.executeAgent(request);
  }

  @Get('admin/providers')
  @ApiOperation({ summary: 'Get all AI provider key pools & rotation status for Admin Dashboard' })
  async getAdminProviders() {
    return {
      success: true,
      providers: this.aiGatewayService.getAllProviderPools(),
    };
  }

  @Post('admin/providers')
  @ApiOperation({ summary: 'Update comma-separated API key pools & priority for an AI provider' })
  async updateAdminProvider(
    @Body() body: { providerId: string; rawKeysString: string; enabled: boolean; priority?: number },
  ) {
    const updated = this.aiGatewayService.updateProviderPool(
      body.providerId,
      body.rawKeysString,
      body.enabled,
      body.priority,
    );
    return {
      success: true,
      updatedProvider: updated,
    };
  }
}
