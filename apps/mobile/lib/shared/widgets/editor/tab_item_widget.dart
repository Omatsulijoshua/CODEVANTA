import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class TabItemWidget extends StatelessWidget {
  final String fileName;
  final bool isActive;
  final bool isDirty;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const TabItemWidget({
    super.key,
    required this.fileName,
    required this.isActive,
    this.isDirty = false,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? (isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite)
              : (isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard),
          border: Border(
            top: BorderSide(
              color: isActive ? CodeVantaColors.electricViolet : Colors.transparent,
              width: 2,
            ),
            right: BorderSide(
              color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDirty)
              Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: CodeVantaColors.cyanAccent,
                  shape: BoxShape.circle,
                ),
              ),
            Text(
              fileName,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive
                    ? (isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary)
                    : (isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                size: 14,
                color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
