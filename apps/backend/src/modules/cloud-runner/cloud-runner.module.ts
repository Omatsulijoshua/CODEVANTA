import { Module } from '@nestjs/common';
import { CloudRunnerController } from './cloud-runner.controller';
import { CloudRunnerService } from './cloud-runner.service';

@Module({
  controllers: [CloudRunnerController],
  providers: [CloudRunnerService],
  exports: [CloudRunnerService],
})
export class CloudRunnerModule {}
