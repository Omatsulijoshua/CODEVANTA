import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';
import '../domain/terminal_session.dart';
import 'mobile_quick_key_bar.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final List<TerminalSession> _sessions = [
    TerminalSession(id: '1', title: 'zsh — 1'),
    TerminalSession(id: '2', title: 'bash — 2'),
  ];
  int _activeSessionIndex = 0;
  double _fontSize = 12.0;
  final _inputController = TextEditingController();

  TerminalSession get _activeSession => _sessions[_activeSessionIndex];

  void _executeCommand() {
    final cmd = _inputController.text.trim();
    if (cmd.isEmpty) return;

    setState(() {
      _activeSession.addCommand(cmd);
      _inputController.clear();

      if (cmd == 'clear') {
        _activeSession.lines.clear();
      } else if (cmd == 'help') {
        _activeSession.addOutput('Available commands: flutter, git, ls, pwd, clear, help');
      } else if (cmd == 'ls') {
        _activeSession.addOutput('lib  pubspec.yaml  README.md  test');
      } else {
        _activeSession.addOutput('Executed "$cmd" in local terminal environment.');
      }
    });
  }

  void _handleQuickKeyPress(String key) {
    if (key == 'Ctrl+C') {
      setState(() => _activeSession.addOutput('^C (Process interrupted)'));
    } else if (key == 'Tab') {
      _inputController.text += '  ';
    } else if (key == 'Up') {
      if (_activeSession.history.isNotEmpty) {
        _inputController.text = _activeSession.history.last;
      }
    } else {
      _inputController.text += key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Terminal — ${_activeSession.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_increase),
            tooltip: 'Increase Font Size',
            onPressed: () => setState(() => _fontSize = (_fontSize + 1).clamp(9.0, 20.0)),
          ),
          IconButton(
            icon: const Icon(Icons.text_decrease),
            tooltip: 'Decrease Font Size',
            onPressed: () => setState(() => _fontSize = (_fontSize - 1).clamp(9.0, 20.0)),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Terminal Tab',
            onPressed: () {
              setState(() {
                _sessions.add(TerminalSession(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: 'sh — ${_sessions.length + 1}',
                ));
                _activeSessionIndex = _sessions.length - 1;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Session Tabs Header
          Container(
            height: 40,
            color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                final isActive = index == _activeSessionIndex;
                return GestureDetector(
                  onTap: () => setState(() => _activeSessionIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive
                          ? (isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite)
                          : Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: isActive ? CodeVantaColors.electricViolet : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      session.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive ? CodeVantaColors.electricViolet : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),

          // Terminal Output Buffer
          Expanded(
            child: Container(
              color: CodeVantaColors.darkGraphite,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: _activeSession.lines.length,
                itemBuilder: (context, index) {
                  final line = _activeSession.lines[index];
                  return Text(
                    line,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: _fontSize,
                      color: line.startsWith('\$') ? CodeVantaColors.cyanAccent : Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),

          // Mobile Quick Key Action Bar
          MobileQuickKeyBar(onKeyPress: _handleQuickKeyPress),
          const Divider(height: 1),

          // Command Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CodeVantaTextField(
                    hintText: 'Type shell command (e.g. flutter analyze, git status)...',
                    controller: _inputController,
                    onSubmitted: (_) => _executeCommand(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: CodeVantaColors.electricViolet),
                  onPressed: _executeCommand,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
