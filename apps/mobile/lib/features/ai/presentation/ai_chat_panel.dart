import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/ghost_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';
import '../data/ai_chat_repository.dart';
import '../domain/ai_chat_models.dart';

class AiChatPanel extends StatefulWidget {
  const AiChatPanel({super.key});

  @override
  State<AiChatPanel> createState() => _AiChatPanelState();
}

class _AiChatPanelState extends State<AiChatPanel> {
  final _repository = AiChatRepository();
  final _promptController = TextEditingController();
  final List<ContextAttachment> _activeAttachments = [];
  bool _isLoading = false;
  String _selectedProvider = 'anthropic';
  String _selectedModel = 'claude-3-5-sonnet';

  final List<AiChatMessage> _messages = [
    AiChatMessage(
      id: '1',
      role: 'assistant',
      content: 'Hello! I am your CodeVanta AI Coding Assistant. How can I help you understand, edit, or refactor your project today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  void _sendMessage() async {
    final text = _promptController.text.trim();
    if (text.isEmpty) return;

    final userMsg = AiChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'user',
      content: text,
      attachments: List.from(_activeAttachments),
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _promptController.clear();
      _activeAttachments.clear();
      _isLoading = true;
    });

    final aiResponse = await _repository.sendExecution(
      provider: _selectedProvider,
      model: _selectedModel,
      userPrompt: text,
      attachments: userMsg.attachments,
    );

    if (mounted) {
      setState(() {
        _messages.add(aiResponse);
        _isLoading = false;
      });
    }
  }

  void _addAttachment(ContextType type, String label) {
    setState(() {
      _activeAttachments.add(ContextAttachment(type: type, label: label, content: 'Sample context data'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.psychology, color: CodeVantaColors.electricViolet, size: 20),
            const SizedBox(width: 8),
            Text('AI Assistant ($_selectedModel)'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.smart_toy_outlined),
            tooltip: 'Select Provider Model',
            onSelected: (val) {
              setState(() {
                if (val == 'claude') {
                  _selectedProvider = 'anthropic';
                  _selectedModel = 'claude-3-5-sonnet';
                } else if (val == 'gpt4') {
                  _selectedProvider = 'openai';
                  _selectedModel = 'gpt-4o';
                } else if (val == 'gemini') {
                  _selectedProvider = 'gemini';
                  _selectedModel = 'gemini-1.5-pro';
                }
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'claude', child: Text('Anthropic — Claude 3.5 Sonnet')),
              PopupMenuItem(value: 'gpt4', child: Text('OpenAI — GPT-4o')),
              PopupMenuItem(value: 'gemini', child: Text('Google — Gemini 1.5 Pro')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Context Attachments Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text('Attach Context: ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ActionChip(label: const Text('@file'), onPressed: () => _addAttachment(ContextType.file, '@file: main.dart')),
                  const SizedBox(width: 4),
                  ActionChip(label: const Text('@selection'), onPressed: () => _addAttachment(ContextType.selection, '@selection')),
                  const SizedBox(width: 4),
                  ActionChip(label: const Text('@terminal'), onPressed: () => _addAttachment(ContextType.terminal, '@terminal')),
                  const SizedBox(width: 4),
                  ActionChip(label: const Text('@error'), onPressed: () => _addAttachment(ContextType.error, '@error')),
                ],
              ),
            ),
          ),
          const Divider(height: 1),

          // Messages View
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.role == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? CodeVantaColors.electricViolet.withValues(alpha: 0.2)
                          : (isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isUser
                            ? CodeVantaColors.electricViolet.withValues(alpha: 0.4)
                            : (isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isUser ? 'You' : 'AI Agent ($_selectedModel)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isUser ? CodeVantaColors.cyanAccent : CodeVantaColors.electricViolet,
                              ),
                            ),
                            if (!isUser)
                              GhostButton(
                                label: 'Apply',
                                icon: Icons.playlist_add_check,
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Applied AI code modifications to workspace!')),
                                  );
                                },
                              ),
                          ],
                        ),
                        if (msg.attachments.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 4,
                            children: msg.attachments
                                .map((a) => StatusPill(label: a.label, type: StatusType.info))
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          msg.content,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(CodeVantaColors.electricViolet)),
              ),
            ),

          // Active Attached Pills Display
          if (_activeAttachments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  const Text('Attached: ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ..._activeAttachments.map(
                    (att) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Chip(
                        label: Text(att.label, style: const TextStyle(fontSize: 10)),
                        onDeleted: () => setState(() => _activeAttachments.remove(att)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // User Input Toolbar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: CodeVantaTextField(
                    hintText: 'Ask AI Agent to edit code, write tests, explain...',
                    controller: _promptController,
                  ),
                ),
                const SizedBox(width: 8),
                PrimaryButton(
                  label: 'Send',
                  icon: Icons.send,
                  fullWidth: false,
                  isLoading: _isLoading,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
