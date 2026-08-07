import 'package:flutter/material.dart';
import '../domain/command_item_model.dart';

class CommandRegistryService {
  final List<CommandItem> _commands = [];
  final List<String> _recentCommandIds = [];

  List<CommandItem> get allCommands => List.unmodifiable(_commands);
  List<String> get recentCommandIds => List.unmodifiable(_recentCommandIds);

  void registerDefaults({
    required VoidCallback onNewFile,
    required VoidCallback onOpenGit,
    required VoidCallback onOpenAi,
    required VoidCallback onOpenTerminal,
    required VoidCallback onSwitchWorkspace,
    required VoidCallback onGlobalSearch,
  }) {
    _commands.clear();
    _commands.addAll([
      CommandItem(
        id: 'file.new',
        title: 'File: Create New File',
        category: CommandCategory.file,
        shortcutHint: 'Cmd+N',
        icon: Icons.note_add_outlined,
        onExecute: onNewFile,
      ),
      CommandItem(
        id: 'search.global',
        title: 'Search: Global Search & Indexing',
        category: CommandCategory.file,
        shortcutHint: 'Cmd+Shift+F',
        icon: Icons.search,
        onExecute: onGlobalSearch,
      ),
      CommandItem(
        id: 'git.open',
        title: 'Git: Open Touch Git Client',
        category: CommandCategory.git,
        shortcutHint: 'Cmd+Shift+G',
        icon: Icons.alt_route,
        onExecute: onOpenGit,
      ),
      CommandItem(
        id: 'ai.open',
        title: 'AI: Open AI Assistant Panel',
        category: CommandCategory.ai,
        shortcutHint: 'Cmd+Shift+A',
        icon: Icons.psychology,
        onExecute: onOpenAi,
      ),
      CommandItem(
        id: 'workspace.switch',
        title: 'Workspace: Switch Layout Style (Classic/Minimal/Focus)',
        category: CommandCategory.workspace,
        icon: Icons.tune,
        onExecute: onSwitchWorkspace,
      ),
      CommandItem(
        id: 'terminal.open',
        title: 'Terminal: Launch Mobile Shell Terminal',
        category: CommandCategory.terminal,
        shortcutHint: 'Cmd+`',
        icon: Icons.terminal,
        onExecute: onOpenTerminal,
      ),
    ]);
  }

  List<CommandItem> search(String query) {
    if (query.isEmpty) return _commands;
    final q = query.toLowerCase();
    return _commands.where((cmd) => cmd.title.toLowerCase().contains(q) || cmd.category.name.toLowerCase().contains(q)).toList();
  }

  void markRecent(String commandId) {
    _recentCommandIds.remove(commandId);
    _recentCommandIds.insert(0, commandId);
  }
}
