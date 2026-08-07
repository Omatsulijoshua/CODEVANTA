import { Injectable } from '@nestjs/common';
import { BaseProviderAdapter } from './base-provider.adapter';
import { AgentExecutionRequest, AgentExecutionResponse } from '../interfaces/agent-protocol.interface';

@Injectable()
export class AnthropicAdapter extends BaseProviderAdapter {
  readonly providerName = 'anthropic';

  async execute(request: AgentExecutionRequest): Promise<AgentExecutionResponse> {
    const lastUserMsg = request.messages.filter((m) => m.role === 'user').pop()?.content || '';

    return {
      id: `msg_anthropic_${Date.now()}`,
      provider: this.providerName,
      model: request.model || 'claude-3-5-sonnet-20241022',
      content: `[Anthropic Claude Adapter Output]: Analyzed project context and processed instruction: "${lastUserMsg}"`,
      usage: {
        promptTokens: 140,
        completionTokens: 95,
        totalTokens: 235,
      },
      timestamp: new Date().toISOString(),
    };
  }
}
