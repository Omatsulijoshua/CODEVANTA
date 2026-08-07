import { Test, TestingModule } from '@nestjs/testing';
import { SubscriptionsController } from './subscriptions.controller';
import { SubscriptionsService } from './subscriptions.service';

describe('SubscriptionsController', () => {
  let controller: SubscriptionsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SubscriptionsController],
      providers: [SubscriptionsService],
    }).compile();

    controller = module.get<SubscriptionsController>(SubscriptionsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should return current subscription entitlements', async () => {
    const sub = await controller.getCurrent();
    expect(sub.tier).toBe('PRO');
    expect(sub.entitlements.allowGitHubSync).toBe(true);
  });

  it('should create checkout session', async () => {
    const checkout = await controller.checkout('PRO');
    expect(checkout.checkoutUrl).toContain('pro');
  });
});
