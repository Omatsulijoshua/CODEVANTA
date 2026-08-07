import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class BreadcrumbBar extends StatelessWidget {
  final List<String> pathSegments;

  const BreadcrumbBar({
    super.key,
    required this.pathSegments,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
      child: Row(
        children: pathSegments.asMap().entries.map((entry) {
          final isLast = entry.key == pathSegments.length - 1;
          return Row(
            children: [
              Text(
                entry.value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                  color: isLast
                      ? (isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary)
                      : (isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary),
                ),
              ),
              if (!isLast)
                Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
