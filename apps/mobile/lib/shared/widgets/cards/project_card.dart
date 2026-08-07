import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../editor/status_pill.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String language;
  final String lastModified;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.language,
    required this.lastModified,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.folder_outlined, color: CodeVantaColors.electricViolet, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                        ),
                      ),
                    ],
                  ),
                  StatusPill(label: language, type: StatusType.info),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Updated $lastModified',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
