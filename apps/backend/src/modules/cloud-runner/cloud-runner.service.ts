import { Injectable } from '@nestjs/common';

@Injectable()
export class CloudRunnerService {
  async provisionContainer(projectId: string) {
    return {
      containerId: `cv-sandbox-${projectId.substring(0, 8)}`,
      status: 'RUNNING',
      allocatedMemoryMb: 2048,
      allocatedCpuCores: 2,
      ipAddress: '10.0.4.12',
      createdAt: new Date().toISOString(),
    };
  }

  async executeCommand(containerId: string, command: string) {
    return {
      executionId: `exec-${Date.now()}`,
      command,
      status: 'SUCCESS',
      exitCode: 0,
      logs: [
        `[CloudRunner stdout] Executing command: ${command}`,
        `[CloudRunner stdout] Building CodeVanta target...`,
        `[CloudRunner stdout] Build completed in 1.42s (0 warnings, 0 errors).`,
      ],
      durationMs: 1420,
    };
  }

  async killProcess(containerId: string) {
    return { status: 'TERMINATED', message: `Container ${containerId} killed successfully.` };
  }
}
