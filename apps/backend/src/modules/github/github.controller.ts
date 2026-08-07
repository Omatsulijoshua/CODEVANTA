import { Controller, Get, Post, Param, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { GitHubService } from './github.service';

@ApiTags('GitHub')
@Controller('api/v1/github')
export class GitHubController {
  constructor(private readonly githubService: GitHubService) {}

  @Get('repos')
  @ApiOperation({ summary: 'List authenticated GitHub repositories' })
  async getRepos() {
    return this.githubService.getRepositories();
  }

  @Get('issues')
  @ApiOperation({ summary: 'List repository issues' })
  async getIssues() {
    return this.githubService.getIssues();
  }

  @Get('pulls')
  @ApiOperation({ summary: 'List open pull requests' })
  async getPullRequests() {
    return this.githubService.getPullRequests();
  }

  @Post('pulls/:id/merge')
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Merge a pull request' })
  async mergePR(@Param('id') id: string) {
    return this.githubService.mergePullRequest(parseInt(id, 10));
  }
}
