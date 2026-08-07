import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const SearchInput({
    super.key,
    this.hintText = 'Search projects, files, symbols...',
    this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
            fontSize: 13,
          ),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, size: 18, color: CodeVantaColors.electricViolet),
          suffixIcon: controller?.text.isNotEmpty == true
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    controller?.clear();
                    if (onClear != null) onClear!();
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
