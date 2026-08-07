import { Injectable, BadRequestException } from '@nestjs/common';
import { OpenAiAdapter } from './adapters/openai.adapter';
import { AnthropicAdapter } from './adapters/anthropic.adapter';
import { GeminiAdapter } from './adapters/gemini.adapter';
import { OpenRouterAdapter } from './adapters/openrouter.adapter';
import { AgentExecutionRequest, AgentExecutionResponse } from './interfaces/agent-protocol.interface';

@Injectable()
export class AiGatewayService {
  constructor(
    private readonly openAiAdapter: OpenAiAdapter,
    private readonly anthropicAdapter: AnthropicAdapter,
    private readonly geminiAdapter: GeminiAdapter,
    private readonly openRouterAdapter: OpenRouterAdapter,
  ) {}

  async executeAgent(request: AgentExecutionRequest): Promise<AgentExecutionResponse> {
    switch (request.provider) {
      case 'openai':
        return this.openAiAdapter.execute(request);
      case 'anthropic':
        return this.anthropicAdapter.execute(request);
      case 'gemini':
        return this.geminiAdapter.execute(request);
      case 'openrouter':
        return this.openRouterAdapter.execute(request);
      default:
        throw new BadRequestException(`Unsupported AI provider: ${request.provider}`);
    }
  }
}
