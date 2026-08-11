import { Injectable, Logger } from '@nestjs/common';
import { AgentExecutionRequest, AgentExecutionResponse } from '../interfaces/agent-protocol.interface';

@Injectable()
export class GroqAdapter {
  private readonly logger = new Logger(GroqAdapter.name);

  async execute(request: AgentExecutionRequest, apiKey?: string): Promise<AgentExecutionResponse> {
    this.logger.log(`[GroqAdapter] Executing prompt using model ${request.model || 'llama-3.3-70b-versatile'} with key ${apiKey ? apiKey.substring(0, 8) + '...' : 'DEFAULT'}`);

    return {
      executionId: `exec_groq_${Date.now()}`,
      provider: 'groq',
      model: request.model || 'llama-3.3-70b-versatile',
      outputText: `[Groq AI Response] Processing prompt: "${request.prompt.substring(0, 60)}..."`,
      tokensUsed: {
        promptTokens: 120,
        completionTokens: 85,
        totalTokens: 205,
      },
      durationMs: 240,
    };
  }
}
