import { Injectable } from '@nestjs/common';

@Injectable()
export class GitHubService {
  async getRepositories() {
    return [
      {
        id: 101,
        name: 'CODEVANTA',
        fullName: 'Omatsulijoshua/CODEVANTA',
        description: 'CodeVanta — Mobile AI Development IDE',
        isPrivate: false,
        stars: 128,
        language: 'Dart',
        updatedAt: new Date().toISOString(),
      },
      {
        id: 102,
        name: 'nest-ai-gateway',
        fullName: 'Omatsulijoshua/nest-ai-gateway',
        description: 'Multi-provider AI Gateway for CodeVanta',
        isPrivate: true,
        stars: 42,
        language: 'TypeScript',
        updatedAt: new Date().toISOString(),
      },
    ];
  }

  async getIssues() {
    return [
      {
        id: 1,
        number: 42,
        title: 'Add support for custom Ollama AI local endpoints',
        state: 'open',
        author: 'Alex Dev',
        createdAt: new Date().toISOString(),
      },
      {
        id: 2,
        number: 38,
        title: 'Optimize syntax highlighting tokenizer latency on iPad Pro',
        state: 'open',
        author: 'Josh Dev',
        createdAt: new Date().toISOString(),
      },
    ];
  }

  async getPullRequests() {
    return [
      {
        id: 1,
        number: 15,
        title: 'feat: implement Phase 7 touch-friendly Git client',
        state: 'open',
        author: 'Alex Dev',
        branch: 'feature/git-integration',
        createdAt: new Date().toISOString(),
      },
    ];
  }

  async mergePullRequest(prId: number) {
    return { status: 'merged', message: `Pull request #${prId} merged successfully.` };
  }
}
