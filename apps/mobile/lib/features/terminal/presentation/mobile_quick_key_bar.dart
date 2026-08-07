import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class MobileQuickKeyBar extends StatelessWidget {
  final ValueChanged<String> onKeyPress;

  const MobileQuickKeyBar({
    super.key,
    required this.onKeyPress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final keys = ['Tab', 'Esc', 'Ctrl+C', '|', '/', '-', '~', '\$', 'Up', 'Down'];

    return Container(
      height: 42,
      color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final keyLabel = keys[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            child: Material(
              color: isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => onKeyPress(keyLabel),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  alignment: Alignment.center,
                  child: Text(
                    keyLabel,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: keyLabel == 'Ctrl+C' ? CodeVantaColors.errorRed : (isDark ? CodeVantaColors.cyanAccent : CodeVantaColors.electricViolet),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
