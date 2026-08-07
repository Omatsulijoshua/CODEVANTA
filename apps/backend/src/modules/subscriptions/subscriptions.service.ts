import { Injectable } from '@nestjs/common';

@Injectable()
export class SubscriptionsService {
  async getCurrentSubscription(userId: string) {
    return {
      userId,
      tier: 'PRO',
      status: 'ACTIVE',
      monthlyPrice: 19,
      currency: 'USD',
      currentPeriodEnd: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
      entitlements: {
        aiQueriesPerMonth: -1, // Unlimited local / 2,000 cloud
        aiQueriesUsed: 142,
        cloudRunnerHoursTotal: 10,
        cloudRunnerHoursUsed: 2.4,
        allowGitHubSync: true,
        allowCustomAiAdapters: true,
        allowCloudRunner: true,
      },
    };
  }

  async createCheckoutSession(userId: string, tier: string) {
    return {
      checkoutUrl: `https://checkout.codevanta.app/pay/${tier.toLowerCase()}?user=${userId}`,
      sessionId: `cs_test_${Date.now()}`,
    };
  }

  async handleWebhook(event: { type: string; data: any }) {
    return { received: true, eventType: event.type };
  }
}
