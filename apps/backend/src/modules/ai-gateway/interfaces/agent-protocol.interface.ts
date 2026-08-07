export interface AgentMessagePayload {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

export interface AgentExecutionRequest {
  provider: 'openai' | 'anthropic' | 'gemini' | 'openrouter';
  model: string;
  messages: AgentMessagePayload[];
  temperature?: number;
  maxTokens?: number;
}

export interface AgentExecutionResponse {
  id: string;
  provider: string;
  model: string;
  content: string;
  usage: {
    promptTokens: number;
    completionTokens: number;
    totalTokens: number;
  };
  timestamp: string;
}
