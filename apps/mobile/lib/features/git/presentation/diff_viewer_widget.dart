import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../domain/git_models.dart';

class DiffViewerWidget extends StatelessWidget {
  final String filePath;
  final List<GitDiffLine> diffLines;

  const DiffViewerWidget({
    super.key,
    required this.filePath,
    required this.diffLines,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Diff: ${filePath.split('/').last}'),
      ),
      body: ListView.builder(
        itemCount: diffLines.length,
        itemBuilder: (context, index) {
          final line = diffLines[index];
          Color bgColor = Colors.transparent;
          Color textColor = isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary;

          if (line.type == 'add') {
            bgColor = CodeVantaColors.successGreen.withValues(alpha: 0.15);
            textColor = CodeVantaColors.successGreen;
          } else if (line.type == 'delete') {
            bgColor = CodeVantaColors.errorRed.withValues(alpha: 0.15);
            textColor = CodeVantaColors.errorRed;
          }

          return Container(
            color: bgColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    line.oldLineNumber?.toString() ?? '',
                    style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'monospace'),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Text(
                    line.newLineNumber?.toString() ?? '',
                    style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'monospace'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    line.content,
                    style: TextStyle(fontSize: 13, fontFamily: 'monospace', color: textColor, fontWeight: line.type != 'normal' ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
