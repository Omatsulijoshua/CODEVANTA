import { Test, TestingModule } from '@nestjs/testing';
import { AiGatewayService } from './ai-gateway.service';
import { OpenAiAdapter } from './adapters/openai.adapter';
import { AnthropicAdapter } from './adapters/anthropic.adapter';
import { GeminiAdapter } from './adapters/gemini.adapter';
import { OpenRouterAdapter } from './adapters/openrouter.adapter';
import { GroqAdapter } from './adapters/groq.adapter';

describe('AiGatewayService', () => {
  let service: AiGatewayService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AiGatewayService,
        OpenAiAdapter,
        AnthropicAdapter,
        GeminiAdapter,
        OpenRouterAdapter,
        GroqAdapter,
      ],
    }).compile();

    service = module.get<AiGatewayService>(AiGatewayService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should route requests to Groq adapter', async () => {
    const res = await service.executeAgent({
      provider: 'groq',
      model: 'llama-3.3-70b-versatile',
      messages: [{ role: 'user', content: 'Explain Rust code' }],
      prompt: 'Explain Rust code',
    });
    expect(res.provider).toBe('groq');
    expect(res.outputText).toContain('Groq AI Response');
  });

  it('should rotate keys in multi-key API pool', () => {
    service.updateProviderPool('groq', 'key_1, key_2, key_3', true);
    const first = service.getNextApiKey('groq');
    const second = service.getNextApiKey('groq');
    const third = service.getNextApiKey('groq');

    expect(first.apiKey).toBe('key_1');
    expect(second.apiKey).toBe('key_2');
    expect(third.apiKey).toBe('key_3');
  });
});
