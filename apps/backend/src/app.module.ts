import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './core/prisma/prisma.module';
import { RedisModule } from './core/redis/redis.module';
import { HealthModule } from './modules/health/health.module';
import { AuthModule } from './modules/auth/auth.module';
import { GitHubModule } from './modules/github/github.module';
import { AiGatewayModule } from './modules/ai-gateway/ai-gateway.module';
import { CloudRunnerModule } from './modules/cloud-runner/cloud-runner.module';
import { SubscriptionsModule } from './modules/subscriptions/subscriptions.module';
import { SecurityModule } from './modules/security/security.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    RedisModule,
    HealthModule,
    AuthModule,
    GitHubModule,
    AiGatewayModule,
    CloudRunnerModule,
    SubscriptionsModule,
    SecurityModule,
  ],
})
export class AppModule {}
