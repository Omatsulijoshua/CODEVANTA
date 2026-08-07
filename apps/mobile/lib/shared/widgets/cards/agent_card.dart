import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../editor/status_pill.dart';

class AgentCard extends StatelessWidget {
  final String name;
  final String provider;
  final String description;
  final String model;
  final bool isSelected;
  final VoidCallback onTap;

  const AgentCard({
    super.key,
    required this.name,
    required this.provider,
    required this.description,
    required this.model,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? CodeVantaColors.electricViolet : (isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: CodeVantaColors.electricViolet.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.psychology, size: 18, color: CodeVantaColors.electricViolet),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                            ),
                          ),
                          Text(
                            provider,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatusPill(label: model, type: StatusType.info),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
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
