import { Module } from '@nestjs/common';
import { AiGatewayController } from './ai-gateway.controller';
import { AiGatewayService } from './ai-gateway.service';
import { OpenAiAdapter } from './adapters/openai.adapter';
import { AnthropicAdapter } from './adapters/anthropic.adapter';
import { GeminiAdapter } from './adapters/gemini.adapter';
import { OpenRouterAdapter } from './adapters/openrouter.adapter';

@Module({
  controllers: [AiGatewayController],
  providers: [
    AiGatewayService,
    OpenAiAdapter,
    AnthropicAdapter,
    GeminiAdapter,
    OpenRouterAdapter,
  ],
  exports: [AiGatewayService],
})
export class AiGatewayModule {}
