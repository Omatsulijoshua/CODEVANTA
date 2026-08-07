import { Test, TestingModule } from '@nestjs/testing';
import { AiGatewayService } from './ai-gateway.service';
import { OpenAiAdapter } from './adapters/openai.adapter';
import { AnthropicAdapter } from './adapters/anthropic.adapter';
import { GeminiAdapter } from './adapters/gemini.adapter';
import { OpenRouterAdapter } from './adapters/openrouter.adapter';

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
      ],
    }).compile();

    service = module.get<AiGatewayService>(AiGatewayService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should route requests to OpenAI adapter', async () => {
    const res = await service.executeAgent({
      provider: 'openai',
      model: 'gpt-4o',
      messages: [{ role: 'user', content: 'Explain code' }],
    });
    expect(res.provider).toBe('openai');
    expect(res.content).toContain('OpenAI');
  });

  it('should route requests to Anthropic adapter', async () => {
    const res = await service.executeAgent({
      provider: 'anthropic',
      model: 'claude-3-5-sonnet',
      messages: [{ role: 'user', content: 'Refactor code' }],
    });
    expect(res.provider).toBe('anthropic');
    expect(res.content).toContain('Anthropic');
  });

  it('should route requests to Gemini adapter', async () => {
    const res = await service.executeAgent({
      provider: 'gemini',
      model: 'gemini-1.5-pro',
      messages: [{ role: 'user', content: 'Generate unit test' }],
    });
    expect(res.provider).toBe('gemini');
    expect(res.content).toContain('Gemini');
  });
});
