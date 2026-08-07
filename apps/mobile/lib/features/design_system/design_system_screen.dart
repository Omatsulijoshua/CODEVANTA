import 'package:flutter/material.dart';
import '../../shared/widgets/brand/codevanta_logo.dart';
import '../../shared/widgets/buttons/destructive_button.dart';
import '../../shared/widgets/buttons/ghost_button.dart';
import '../../shared/widgets/buttons/primary_button.dart';
import '../../shared/widgets/buttons/secondary_button.dart';
import '../../shared/widgets/cards/agent_card.dart';
import '../../shared/widgets/cards/file_list_item.dart';
import '../../shared/widgets/cards/project_card.dart';
import '../../shared/widgets/editor/breadcrumb_bar.dart';
import '../../shared/widgets/editor/status_pill.dart';
import '../../shared/widgets/editor/tab_item_widget.dart';
import '../../shared/widgets/feedback/empty_state_widget.dart';
import '../../shared/widgets/feedback/error_display_widget.dart';
import '../../shared/widgets/inputs/codevanta_text_field.dart';
import '../../shared/widgets/inputs/search_input.dart';
import '../../shared/widgets/navigation/responsive_navigation_rail.dart';

class DesignSystemScreen extends StatefulWidget {
  const DesignSystemScreen({super.key});

  @override
  State<DesignSystemScreen> createState() => _DesignSystemScreenState();
}

class _DesignSystemScreenState extends State<DesignSystemScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      destinations: const [
        NavigationDestinationItem(icon: Icons.palette_outlined, selectedIcon: Icons.palette, label: 'Design System'),
        NavigationDestinationItem(icon: Icons.folder_outlined, selectedIcon: Icons.folder, label: 'Projects'),
        NavigationDestinationItem(icon: Icons.psychology_outlined, selectedIcon: Icons.psychology, label: 'Agents'),
      ],
      body: Scaffold(
        appBar: AppBar(
          title: const CodeVantaLogo(size: 28, style: LogoStyle.horizontal),
          actions: [
            IconButton(
              icon: const Icon(Icons.lightbulb_outline),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text('Branding & Typography', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const CodeVantaLogo(size: 44, style: LogoStyle.horizontal),
            const SizedBox(height: 24),
            
            const Text('Status Pills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 8,
              children: [
                StatusPill(label: 'CONNECTED', type: StatusType.success),
                StatusPill(label: 'BUILDING', type: StatusType.warning),
                StatusPill(label: 'FAILED', type: StatusType.error),
                StatusPill(label: 'FLUTTER 3.44', type: StatusType.info),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            PrimaryButton(label: 'Create New Project', icon: Icons.add, onPressed: () {}),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: SecondaryButton(label: 'Clone Repo', icon: Icons.download, onPressed: () {})),
                const SizedBox(width: 8),
                GhostButton(label: 'Skip', onPressed: () {}),
              ],
            ),
            const SizedBox(height: 8),
            DestructiveButton(label: 'Delete Project Snapshot', icon: Icons.delete, onPressed: () {}),
            const SizedBox(height: 24),

            const Text('Inputs & Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const SearchInput(),
            const SizedBox(height: 8),
            const CodeVantaTextField(label: 'Project Name', hintText: 'my_flutter_app'),
            const SizedBox(height: 24),

            const Text('Editor Components', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                TabItemWidget(fileName: 'main.dart', isActive: true, isDirty: true, onTap: () {}, onClose: () {}),
                TabItemWidget(fileName: 'app_config.dart', isActive: false, isDirty: false, onTap: () {}, onClose: () {}),
              ],
            ),
            const BreadcrumbBar(pathSegments: ['lib', 'core', 'theme', 'codevanta_theme.dart']),
            const SizedBox(height: 24),

            const Text('Cards & Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ProjectCard(title: 'CodeVanta IDE', language: 'Dart/Flutter', lastModified: '2 mins ago', onTap: () {}),
            AgentCard(
              name: 'Claude 3.5 Sonnet Agent',
              provider: 'Anthropic Provider Adapter',
              description: 'Full codebase context understanding, refactoring, and automated diff generation.',
              model: 'claude-3-5-sonnet',
              isSelected: true,
              onTap: () {},
            ),
            FileListItem(fileName: 'pubspec.yaml', isFolder: false, onTap: () {}),
            const SizedBox(height: 24),

            const Text('Feedback & Error States', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const ErrorDisplayWidget(errorMessage: 'Failed to connect to local development sandbox container.'),
            const SizedBox(height: 12),
            const EmptyStateWidget(
              title: 'No Active AI Sessions',
              description: 'Select an AI provider agent from the marketplace to initiate code generation.',
            ),
          ],
        ),
      ),
    );
  }
}
