import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';

class SearchReplaceBar extends StatelessWidget {
  final TextEditingController searchController;
  final TextEditingController replaceController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onReplaceAll;
  final VoidCallback onClose;

  const SearchReplaceBar({
    super.key,
    required this.searchController,
    required this.replaceController,
    required this.onSearchChanged,
    required this.onReplaceAll,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'Find in file...',
                    isDense: true,
                    prefixIcon: Icon(Icons.search, size: 16),
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.close, size: 18), onPressed: onClose),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: replaceController,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'Replace with...',
                    isDense: true,
                    prefixIcon: Icon(Icons.find_replace, size: 16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SecondaryButton(label: 'Replace All', onPressed: onReplaceAll),
            ],
          ),
        ],
      ),
    );
  }
}
