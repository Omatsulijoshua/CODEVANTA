import 'package:flutter/material.dart';

enum CommandCategory { file, project, git, ai, workspace, terminal, settings }

class CommandItem {
  final String id;
  final String title;
  final CommandCategory category;
  final String? shortcutHint;
  final IconData icon;
  final VoidCallback onExecute;

  const CommandItem({
    required this.id,
    required this.title,
    required this.category,
    this.shortcutHint,
    required this.icon,
    required this.onExecute,
  });
}
