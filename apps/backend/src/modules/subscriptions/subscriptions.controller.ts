import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { SubscriptionsService } from './subscriptions.service';

@ApiTags('Subscriptions')
@Controller('api/v1/subscriptions')
export class SubscriptionsController {
  constructor(private readonly subscriptionsService: SubscriptionsService) {}

  @Get('current')
  @ApiOperation({ summary: 'Fetch active user subscription tier and entitlements' })
  async getCurrent() {
    return this.subscriptionsService.getCurrentSubscription('user-demo-123');
  }

  @Post('checkout')
  @ApiOperation({ summary: 'Create Stripe / Apple IAP checkout session' })
  async checkout(@Body('tier') tier: string) {
    return this.subscriptionsService.createCheckoutSession('user-demo-123', tier || 'PRO');
  }

  @Post('webhook')
  @ApiOperation({ summary: 'Stripe / IAP webhook listener for subscription billing events' })
  async webhook(@Body() payload: any) {
    return this.subscriptionsService.handleWebhook(payload);
  }
}
