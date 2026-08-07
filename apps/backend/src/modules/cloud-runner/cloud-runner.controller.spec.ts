import { Test, TestingModule } from '@nestjs/testing';
import { CloudRunnerController } from './cloud-runner.controller';
import { CloudRunnerService } from './cloud-runner.service';

describe('CloudRunnerController', () => {
  let controller: CloudRunnerController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CloudRunnerController],
      providers: [CloudRunnerService],
    }).compile();

    controller = module.get<CloudRunnerController>(CloudRunnerController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should provision a container', async () => {
    const result = await controller.provision('proj-123');
    expect(result.containerId).toBeDefined();
    expect(result.status).toBe('RUNNING');
  });

  it('should execute a command', async () => {
    const exec = await controller.execute({ containerId: 'cv-sandbox-1', command: 'flutter build apk' });
    expect(exec.status).toBe('SUCCESS');
    expect(exec.logs.length).toBeGreaterThan(0);
  });
});
