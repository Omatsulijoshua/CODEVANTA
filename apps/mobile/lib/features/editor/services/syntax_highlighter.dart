import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class SyntaxHighlighter {
  static TextSpan formatCode(String code, String language, bool isDark) {
    final defaultStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
    );

    final keywordStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: isDark ? CodeVantaColors.electricViolet : const Color(0xFF6A1B9A),
    );

    final stringStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      color: isDark ? CodeVantaColors.cyanAccent : const Color(0xFF00838F),
    );

    final commentStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      fontStyle: FontStyle.italic,
      color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
    );

    const numberStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      color: Color(0xFFFF9800),
    );

    final List<TextSpan> spans = [];
    final lines = code.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim().startsWith('//') || line.trim().startsWith('#')) {
        spans.add(TextSpan(text: line, style: commentStyle));
      } else {
        final words = line.split(RegExp(r'(\s+|[(){}.,;])'));
        for (final word in words) {
          if (['class', 'import', 'void', 'final', 'const', 'return', 'async', 'await', 'def', 'fn', 'function', 'let', 'var', 'if', 'else', 'for', 'while'].contains(word)) {
            spans.add(TextSpan(text: word, style: keywordStyle));
          } else if (word.startsWith('"') || word.startsWith("'")) {
            spans.add(TextSpan(text: word, style: stringStyle));
          } else if (RegExp(r'^\d+$').hasMatch(word)) {
            spans.add(TextSpan(text: word, style: numberStyle));
          } else {
            spans.add(TextSpan(text: word, style: defaultStyle));
          }
        }
      }
      if (i < lines.length - 1) {
        spans.add(TextSpan(text: '\n', style: defaultStyle));
      }
    }

    return TextSpan(children: spans);
  }
}
