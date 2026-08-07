import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import 'paywall_modal.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  String _activeTier = 'PRO TIER';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions & Entitlements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Plan Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Active Subscription', style: TextStyle(fontSize: 13, color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary)),
                        StatusPill(label: _activeTier, type: StatusType.success),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('CodeVanta Pro Plan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text('\$19.00 / month • Renews in 24 days', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Usage Meters & Limits', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Usage Meters
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cloud AI Queries', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('142 / 2,000 queries', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 6),
                    LinearProgressIndicator(value: 142 / 2000, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation(CodeVantaColors.electricViolet)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cloud Runner Hours', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('2.4 / 10.0 hrs', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 6),
                    LinearProgressIndicator(value: 2.4 / 10.0, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation(CodeVantaColors.cyanAccent)),
                  ],
                ),
              ),
            ),
            const Spacer(),

            PrimaryButton(
              label: 'Upgrade / Change Subscription Plan',
              onPressed: () {
                PaywallModal.show(context, onUpgrade: () {
                  setState(() => _activeTier = 'PRO TIER (UPGRADED)');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Subscription upgraded successfully!')),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
