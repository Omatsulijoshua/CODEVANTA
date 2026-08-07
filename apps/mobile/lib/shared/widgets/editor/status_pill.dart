import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

enum StatusType { success, warning, error, info }

class StatusPill extends StatelessWidget {
  final String label;
  final StatusType type;

  const StatusPill({
    super.key,
    required this.label,
    this.type = StatusType.info,
  });

  Color _getColor() {
    switch (type) {
      case StatusType.success:
        return CodeVantaColors.successGreen;
      case StatusType.warning:
        return CodeVantaColors.warningAmber;
      case StatusType.error:
        return CodeVantaColors.errorRed;
      case StatusType.info:
        return CodeVantaColors.cyanAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
