import { Injectable, BadRequestException, Logger } from '@nestjs/common';
import { OpenAiAdapter } from './adapters/openai.adapter';
import { AnthropicAdapter } from './adapters/anthropic.adapter';
import { GeminiAdapter } from './adapters/gemini.adapter';
import { OpenRouterAdapter } from './adapters/openrouter.adapter';
import { GroqAdapter } from './adapters/groq.adapter';
import { AgentExecutionRequest, AgentExecutionResponse } from './interfaces/agent-protocol.interface';

export interface ProviderKeyPoolConfig {
  id: 'openai' | 'anthropic' | 'gemini' | 'openrouter' | 'groq';
  name: string;
  enabled: boolean;
  priority: number;
  rawKeysString: string;
  parsedKeys: string[];
  currentKeyIndex: number;
  models: string[];
  rateLimitCount: number;
}

@Injectable()
export class AiGatewayService {
  private readonly logger = new Logger(AiGatewayService.name);

  private providerPools: Map<string, ProviderKeyPoolConfig> = new Map([
    [
      'groq',
      {
        id: 'groq',
        name: 'Groq Cloud AI',
        enabled: true,
        priority: 1,
        rawKeysString: 'gsk_key1_abc123, gsk_key2_xyz789',
        parsedKeys: ['gsk_key1_abc123', 'gsk_key2_xyz789'],
        currentKeyIndex: 0,
        models: ['llama-3.3-70b-versatile', 'mixtral-8x7b-32768'],
        rateLimitCount: 0,
      },
    ],
    [
      'gemini',
      {
        id: 'gemini',
        name: 'Google Gemini',
        enabled: true,
        priority: 2,
        rawKeysString: 'AIzaSy_key1_def456, AIzaSy_key2_uvw123',
        parsedKeys: ['AIzaSy_key1_def456', 'AIzaSy_key2_uvw123'],
        currentKeyIndex: 0,
        models: ['gemini-1.5-pro', 'gemini-1.5-flash'],
        rateLimitCount: 0,
      },
    ],
    [
      'openai',
      {
        id: 'openai',
        name: 'OpenAI',
        enabled: true,
        priority: 3,
        rawKeysString: 'sk-proj-openai-key-1, sk-proj-openai-key-2',
        parsedKeys: ['sk-proj-openai-key-1', 'sk-proj-openai-key-2'],
        currentKeyIndex: 0,
        models: ['gpt-4o', 'gpt-4-turbo'],
        rateLimitCount: 0,
      },
    ],
    [
      'anthropic',
      {
        id: 'anthropic',
        name: 'Anthropic Claude',
        enabled: true,
        priority: 4,
        rawKeysString: 'sk-ant-claude-key-1',
        parsedKeys: ['sk-ant-claude-key-1'],
        currentKeyIndex: 0,
        models: ['claude-3-5-sonnet-20241022', 'claude-3-opus-20240229'],
        rateLimitCount: 0,
      },
    ],
    [
      'openrouter',
      {
        id: 'openrouter',
        name: 'OpenRouter Aggregator',
        enabled: false,
        priority: 5,
        rawKeysString: '',
        parsedKeys: [],
        currentKeyIndex: 0,
        models: ['meta-llama/llama-3.3-70b-instruct'],
        rateLimitCount: 0,
      },
    ],
  ]);

  constructor(
    private readonly openAiAdapter: OpenAiAdapter,
    private readonly anthropicAdapter: AnthropicAdapter,
    private readonly geminiAdapter: GeminiAdapter,
    private readonly openRouterAdapter: OpenRouterAdapter,
    private readonly groqAdapter: GroqAdapter,
  ) {}

  public getNextApiKey(providerId: string): { apiKey: string; keyIndex: number; totalKeys: number } {
    const config = this.providerPools.get(providerId);
    if (!config || !config.enabled || config.parsedKeys.length === 0) {
      return { apiKey: '', keyIndex: 0, totalKeys: 0 };
    }

    const keyIndex = config.currentKeyIndex;
    const apiKey = config.parsedKeys[keyIndex];

    // Rotate to next key for load-balancing / rate-limit optimization
    config.currentKeyIndex = (config.currentKeyIndex + 1) % config.parsedKeys.length;
    this.providerPools.set(providerId, config);

    return { apiKey, keyIndex, totalKeys: config.parsedKeys.length };
  }

  async executeAgent(request: AgentExecutionRequest): Promise<AgentExecutionResponse> {
    const { apiKey, keyIndex, totalKeys } = this.getNextApiKey(request.provider);
    this.logger.log(`Executing provider=${request.provider} keyIndex=${keyIndex}/${totalKeys}`);

    try {
      switch (request.provider) {
        case 'groq':
          return await this.groqAdapter.execute(request, apiKey);
        case 'gemini':
          return await this.geminiAdapter.execute(request);
        case 'openai':
          return await this.openAiAdapter.execute(request);
        case 'anthropic':
          return await this.anthropicAdapter.execute(request);
        case 'openrouter':
          return await this.openRouterAdapter.execute(request);
        default:
          throw new BadRequestException(`Unsupported AI provider: ${request.provider}`);
      }
    } catch (err) {
      this.logger.warn(`Primary provider ${request.provider} failed: ${err.message}. Attempting fallback chain.`);

      const fallbackProviders = Array.from(this.providerPools.values())
        .filter((p) => p.enabled && p.id !== request.provider && p.parsedKeys.length > 0)
        .sort((a, b) => a.priority - b.priority);

      if (fallbackProviders.length > 0) {
        const fallback = fallbackProviders[0];
        this.logger.log(`Falling back to ${fallback.id}`);
        return this.executeAgent({ ...request, provider: fallback.id });
      }

      throw err;
    }
  }

  // Admin APIs
  getAllProviderPools(): ProviderKeyPoolConfig[] {
    return Array.from(this.providerPools.values()).sort((a, b) => a.priority - b.priority);
  }

  updateProviderPool(providerId: string, rawKeysString: string, enabled: boolean, priority?: number): ProviderKeyPoolConfig {
    const validId = providerId as 'openai' | 'anthropic' | 'gemini' | 'openrouter' | 'groq';
    const config = this.providerPools.get(providerId) || {
      id: validId,
      name: providerId.toUpperCase(),
      enabled: true,
      priority: 99,
      rawKeysString: '',
      parsedKeys: [],
      currentKeyIndex: 0,
      models: [],
      rateLimitCount: 0,
    };

    const parsedKeys = rawKeysString
      .split(',')
      .map((k) => k.trim())
      .filter((k) => k.length > 0);

    config.rawKeysString = rawKeysString;
    config.parsedKeys = parsedKeys;
    config.enabled = enabled;
    if (priority !== undefined) config.priority = priority;
    config.currentKeyIndex = 0;

    this.providerPools.set(providerId, config);
    this.logger.log(`Updated AI Provider pool ${providerId}: ${parsedKeys.length} active keys loaded.`);
    return config;
  }
}
