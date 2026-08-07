import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../buttons/destructive_button.dart';
import '../buttons/ghost_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    required this.onConfirm,
    this.isDestructive = false,
  });

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
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
          fontSize: 14,
        ),
      ),
      actions: [
        GhostButton(
          label: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (isDestructive)
          DestructiveButton(
            label: confirmLabel,
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
          )
        else
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CodeVantaColors.electricViolet,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(confirmLabel, style: const TextStyle(color: Colors.white)),
          ),
      ],
    );
  }
}
