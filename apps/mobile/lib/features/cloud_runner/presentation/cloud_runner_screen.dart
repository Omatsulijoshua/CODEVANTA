import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/destructive_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
import '../../../shared/widgets/editor/status_pill.dart';

class CloudRunnerScreen extends StatefulWidget {
  const CloudRunnerScreen({super.key});

  @override
  State<CloudRunnerScreen> createState() => _CloudRunnerScreenState();
}

class _CloudRunnerScreenState extends State<CloudRunnerScreen> {
  final List<String> _logs = [
    '[CloudRunner init] Provisioning isolated sandbox container cv-sandbox-9f8a2...',
    '[CloudRunner init] Sandbox ready: 2 vCPU, 2048 MB RAM, IP: 10.0.4.12.',
  ];
  bool _isRunning = false;
  String _containerStatus = 'RUNNING';

  void _runCommand(String cmd) {
    setState(() {
      _isRunning = true;
      _logs.add('> Executing: $cmd');
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _logs.add('[stdout] Executing $cmd in sandbox...');
          _logs.add('[stdout] Success: command finished with exit code 0.');
          _isRunning = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Runner Sandbox'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: StatusPill(
              label: 'CONTAINER: $_containerStatus',
              type: _containerStatus == 'RUNNING' ? StatusType.success : StatusType.error,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Resource Telemetry Bar
          Container(
            padding: const EdgeInsets.all(12),
            color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('CPU: 12% / 2 vCPU', style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                Text('RAM: 340 MB / 2048 MB', style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                Text('Port: 8080 (Mapped)', style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ],
            ),
          ),
          const Divider(height: 1),

          // Terminal Output Screen
          Expanded(
            child: Container(
              color: CodeVantaColors.darkGraphite,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final line = _logs[index];
                  Color textColor = Colors.white;
                  if (line.startsWith('>')) textColor = CodeVantaColors.cyanAccent;
                  if (line.contains('Success')) textColor = CodeVantaColors.successGreen;

                  return Text(
                    line,
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: textColor),
                  );
                },
              ),
            ),
          ),

          // Execution Toolbar
          Container(
            padding: const EdgeInsets.all(12),
            color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PrimaryButton(
                    label: 'Run Build',
                    icon: Icons.build_outlined,
                    fullWidth: false,
                    isLoading: _isRunning,
                    onPressed: () => _runCommand('flutter build web'),
                  ),
                  const SizedBox(width: 8),
                  SecondaryButton(
                    label: 'Run Tests',
                    icon: Icons.checklist_outlined,
                    onPressed: () => _runCommand('flutter test'),
                  ),
                  const SizedBox(width: 8),
                  SecondaryButton(
                    label: 'Run Lint',
                    icon: Icons.spellcheck,
                    onPressed: () => _runCommand('flutter analyze'),
                  ),
                  const SizedBox(width: 8),
                  DestructiveButton(
                    label: 'Kill Sandbox',
                    icon: Icons.power_settings_new,
                    onPressed: () {
                      setState(() {
                        _containerStatus = 'TERMINATED';
                        _logs.add('[CloudRunner sys] Container terminated by developer.');
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
