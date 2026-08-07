import { Controller, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { CloudRunnerService } from './cloud-runner.service';

@ApiTags('Cloud Runner')
@Controller('api/v1/cloud-runner')
export class CloudRunnerController {
  constructor(private readonly cloudRunnerService: CloudRunnerService) {}

  @Post('provision')
  @ApiOperation({ summary: 'Provision isolated remote execution container' })
  async provision(@Body('projectId') projectId: string) {
    return this.cloudRunnerService.provisionContainer(projectId || 'demo-project');
  }

  @Post('execute')
  @ApiOperation({ summary: 'Execute remote shell command in container' })
  async execute(@Body() body: { containerId: string; command: string }) {
    return this.cloudRunnerService.executeCommand(body.containerId, body.command);
  }

  @Post('kill')
  @ApiOperation({ summary: 'Kill remote container execution process' })
  async kill(@Body('containerId') containerId: string) {
    return this.cloudRunnerService.killProcess(containerId);
  }
}
