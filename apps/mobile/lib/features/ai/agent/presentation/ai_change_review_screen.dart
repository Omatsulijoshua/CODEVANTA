import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../../shared/widgets/buttons/destructive_button.dart';
import '../../../../shared/widgets/buttons/ghost_button.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../shared/widgets/editor/status_pill.dart';
import '../domain/agent_permission_model.dart';

class AiChangeReviewScreen extends StatefulWidget {
  final List<AiFileChange> changes;

  const AiChangeReviewScreen({
    super.key,
    required this.changes,
  });

  @override
  State<AiChangeReviewScreen> createState() => _AiChangeReviewScreenState();
}

class _AiChangeReviewScreenState extends State<AiChangeReviewScreen> {
  late List<AiFileChange> _pendingChanges;

  @override
  void initState() {
    super.initState();
    _pendingChanges = List.from(widget.changes);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review AI Generated Changes'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: StatusPill(label: 'SNAPSHOT PROTECTED', type: StatusType.success),
          ),
        ],
      ),
      body: _pendingChanges.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 48, color: CodeVantaColors.successGreen),
                  const SizedBox(height: 12),
                  const Text('All AI changes have been reviewed and accepted!'),
                  const SizedBox(height: 16),
                  SecondaryButton(label: 'Return to Workspace', onPressed: () => Navigator.pop(context)),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_pendingChanges.length} files modified by AI Agent',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            DestructiveButton(
                              label: 'Rollback Snapshot',
                              icon: Icons.history,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Rolled back all AI changes to pre-edit snapshot.')),
                                );
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 8),
                            PrimaryButton(
                              label: 'Accept All Files',
                              fullWidth: false,
                              onPressed: () {
                                setState(() => _pendingChanges.clear());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Accepted all AI code modifications!')),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _pendingChanges.length,
                    itemBuilder: (context, index) {
                      final item = _pendingChanges[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
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
                                      const Icon(Icons.description_outlined, color: CodeVantaColors.electricViolet, size: 20),
                                      const SizedBox(width: 8),
                                      Text(item.filePath, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GhostButton(
                                        label: 'Reject File',
                                        onPressed: () => setState(() => _pendingChanges.removeAt(index)),
                                      ),
                                      const SizedBox(width: 6),
                                      PrimaryButton(
                                        label: 'Accept File',
                                        fullWidth: false,
                                        onPressed: () => setState(() => _pendingChanges.removeAt(index)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Visual Diff Box
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('- ${item.oldContent}', style: const TextStyle(color: CodeVantaColors.errorRed, fontFamily: 'monospace', fontSize: 12)),
                                    const SizedBox(height: 4),
                                    Text('+ ${item.newContent}', style: const TextStyle(color: CodeVantaColors.successGreen, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
