import { AgentExecutionRequest, AgentExecutionResponse } from '../interfaces/agent-protocol.interface';

export abstract class BaseProviderAdapter {
  abstract readonly providerName: string;
  abstract execute(request: AgentExecutionRequest): Promise<AgentExecutionResponse>;
}
