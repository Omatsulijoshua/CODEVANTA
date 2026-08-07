import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class CodeVantaTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CodeVantaTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyle(
            color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18, color: CodeVantaColors.electricViolet)
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, size: 18, color: CodeVantaColors.textDarkSecondary)
                : null,
          ),
        ),
      ],
    );
  }
}
