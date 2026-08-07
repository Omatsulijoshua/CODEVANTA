import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
import '../../../shared/widgets/editor/status_pill.dart';

class PaywallModal extends StatelessWidget {
  final VoidCallback onUpgrade;

  const PaywallModal({
    super.key,
    required this.onUpgrade,
  });

  static void show(BuildContext context, {required VoidCallback onUpgrade}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PaywallModal(onUpgrade: onUpgrade),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          const StatusPill(label: 'UNLOCK PRO IDE CAPABILITIES', type: StatusType.warning),
          const SizedBox(height: 12),
          Text(
            'Upgrade to CodeVanta Pro',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Professional mobile development with unlimited AI queries, cloud runners & GitHub sync.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary),
          ),
          const SizedBox(height: 20),

          // Plan Features Checklist
          const Column(
            children: [
              ListTile(
                dense: true,
                leading: Icon(Icons.check_circle, color: CodeVantaColors.electricViolet),
                title: Text('Unlimited Local AI & 2,000 Cloud Tokens/mo'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.check_circle, color: CodeVantaColors.electricViolet),
                title: Text('10 Hours/mo Cloud Runner Sandbox Execution'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.check_circle, color: CodeVantaColors.electricViolet),
                title: Text('Full GitHub Integration & Cloud Sync'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          PrimaryButton(
            label: 'Start Pro Trial — \$19 / month',
            onPressed: () {
              Navigator.pop(context);
              onUpgrade();
            },
          ),
          const SizedBox(height: 8),
          SecondaryButton(
            label: 'Continue with Free Local IDE',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
