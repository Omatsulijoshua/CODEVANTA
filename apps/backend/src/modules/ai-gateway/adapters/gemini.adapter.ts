import { Injectable } from '@nestjs/common';
import { BaseProviderAdapter } from './base-provider.adapter';
import { AgentExecutionRequest, AgentExecutionResponse } from '../interfaces/agent-protocol.interface';

@Injectable()
export class GeminiAdapter extends BaseProviderAdapter {
  readonly providerName = 'gemini';

  async execute(request: AgentExecutionRequest): Promise<AgentExecutionResponse> {
    const lastUserMsg = request.messages.filter((m) => m.role === 'user').pop()?.content || '';

    return {
      id: `gemini-${Date.now()}`,
      provider: this.providerName,
      model: request.model || 'gemini-1.5-pro',
      content: `[Google Gemini Adapter Output]: Executed request with multimodal capability: "${lastUserMsg}"`,
      usage: {
        promptTokens: 110,
        completionTokens: 80,
        totalTokens: 190,
      },
      timestamp: new Date().toISOString(),
    };
  }
}
