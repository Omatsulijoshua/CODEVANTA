import { Injectable } from '@nestjs/common';
import { BaseProviderAdapter } from './base-provider.adapter';
import { AgentExecutionRequest, AgentExecutionResponse } from '../interfaces/agent-protocol.interface';

@Injectable()
export class OpenAiAdapter extends BaseProviderAdapter {
  readonly providerName = 'openai';

  async execute(request: AgentExecutionRequest): Promise<AgentExecutionResponse> {
    const lastUserMsg = request.messages.filter((m) => m.role === 'user').pop()?.content || '';

    return {
      id: `chatcmpl-${Date.now()}`,
      provider: this.providerName,
      model: request.model || 'gpt-4o',
      content: `[OpenAI Adapter Output for model ${request.model}]: Processed request: "${lastUserMsg}"`,
      usage: {
        promptTokens: 120,
        completionTokens: 85,
        totalTokens: 205,
      },
      timestamp: new Date().toISOString(),
    };
  }
}
