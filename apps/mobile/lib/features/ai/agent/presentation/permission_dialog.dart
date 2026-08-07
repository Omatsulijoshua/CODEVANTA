import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../../shared/widgets/buttons/destructive_button.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../domain/agent_permission_model.dart';

class PermissionDialog extends StatelessWidget {
  final PermissionScope scope;
  final String actionDescription;
  final ValueChanged<PermissionGrant> onResult;

  const PermissionDialog({
    super.key,
    required this.scope,
    required this.actionDescription,
    required this.onResult,
  });

  static Future<PermissionGrant?> show({
    required BuildContext context,
    required PermissionScope scope,
    required String actionDescription,
  }) {
    return showDialog<PermissionGrant>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PermissionDialog(
        scope: scope,
        actionDescription: actionDescription,
        onResult: (grant) => Navigator.pop(ctx, grant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
        ),
      ),
      title: Row(
        children: [
          const Icon(Icons.shield_outlined, color: CodeVantaColors.warningAmber, size: 24),
          const SizedBox(width: 8),
          Text(
            'AI Permission Scope',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The AI Agent is requesting permission to perform the following action:',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CodeVantaColors.electricViolet.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.code, color: CodeVantaColors.cyanAccent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    actionDescription,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        DestructiveButton(
          label: 'Deny',
          onPressed: () => onResult(PermissionGrant.deny),
        ),
        SecondaryButton(
          label: 'Allow Once',
          onPressed: () => onResult(PermissionGrant.allowOnce),
        ),
        PrimaryButton(
          label: 'Always Allow',
          fullWidth: false,
          onPressed: () => onResult(PermissionGrant.alwaysAllow),
        ),
      ],
    );
  }
}
