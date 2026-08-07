import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class FileListItem extends StatelessWidget {
  final String fileName;
  final bool isFolder;
  final VoidCallback onTap;

  const FileListItem({
    super.key,
    required this.fileName,
    this.isFolder = false,
    required this.onTap,
  });

  IconData _getIcon() {
    if (isFolder) return Icons.folder;
    if (fileName.endsWith('.dart')) return Icons.code;
    if (fileName.endsWith('.json')) return Icons.data_object;
    if (fileName.endsWith('.md')) return Icons.description;
    return Icons.insert_drive_file_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        dense: true,
        onTap: onTap,
        leading: Icon(
          _getIcon(),
          color: isFolder ? CodeVantaColors.electricViolet : CodeVantaColors.cyanAccent,
          size: 18,
        ),
        title: Text(
          fileName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isFolder ? FontWeight.bold : FontWeight.normal,
            color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
          ),
        ),
      ),
    );
  }
}
