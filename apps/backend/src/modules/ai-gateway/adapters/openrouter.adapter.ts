import { Injectable } from '@nestjs/common';
import { BaseProviderAdapter } from './base-provider.adapter';
import { AgentExecutionRequest, AgentExecutionResponse } from '../interfaces/agent-protocol.interface';

@Injectable()
export class OpenRouterAdapter extends BaseProviderAdapter {
  readonly providerName = 'openrouter';

  async execute(request: AgentExecutionRequest): Promise<AgentExecutionResponse> {
    const lastUserMsg = request.messages.filter((m) => m.role === 'user').pop()?.content || '';

    return {
      id: `openrouter-${Date.now()}`,
      provider: this.providerName,
      model: request.model || 'meta-llama/llama-3-70b-instruct',
      content: `[OpenRouter Unified Adapter Output]: Routed through OpenRouter gateway: "${lastUserMsg}"`,
      usage: {
        promptTokens: 130,
        completionTokens: 90,
        totalTokens: 220,
      },
      timestamp: new Date().toISOString(),
    };
  }
}
