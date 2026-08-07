import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../buttons/secondary_button.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String title;
  final String errorMessage;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    super.key,
    this.title = 'Operation Failed',
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CodeVantaColors.errorRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CodeVantaColors.errorRed.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: CodeVantaColors.errorRed, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  errorMessage,
                  style: const TextStyle(fontSize: 12, color: CodeVantaColors.errorRed),
                ),
              ],
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            SecondaryButton(label: 'Retry', onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}
