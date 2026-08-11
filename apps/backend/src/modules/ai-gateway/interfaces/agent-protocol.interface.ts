export interface AgentMessagePayload {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

export interface AgentExecutionRequest {
  provider: 'openai' | 'anthropic' | 'gemini' | 'openrouter' | 'groq';
  model: string;
  messages: AgentMessagePayload[];
  prompt?: string;
  temperature?: number;
  maxTokens?: number;
}

export interface AgentExecutionResponse {
  executionId?: string;
  id?: string;
  provider: string;
  model: string;
  outputText?: string;
  content?: string;
  tokensUsed?: {
    promptTokens: number;
    completionTokens: number;
    totalTokens: number;
  };
  usage?: {
    promptTokens: number;
    completionTokens: number;
    totalTokens: number;
  };
  durationMs?: number;
  timestamp?: string;
}
