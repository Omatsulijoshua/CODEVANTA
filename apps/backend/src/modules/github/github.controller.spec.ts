import { Test, TestingModule } from '@nestjs/testing';
import { GitHubController } from './github.controller';
import { GitHubService } from './github.service';

describe('GitHubController', () => {
  let controller: GitHubController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [GitHubController],
      providers: [GitHubService],
    }).compile();

    controller = module.get<GitHubController>(GitHubController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should return repositories', async () => {
    const repos = await controller.getRepos();
    expect(repos.length).toBeGreaterThan(0);
    expect(repos[0].name).toBe('CODEVANTA');
  });
});
