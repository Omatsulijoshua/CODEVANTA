enum ContextType { file, folder, project, selection, terminal, git, error }

class ContextAttachment {
  final ContextType type;
  final String label;
  final String content;

  const ContextAttachment({
    required this.type,
    required this.label,
    required this.content,
  });
}

class AiChatMessage {
  final String id;
  final String role; // 'user' | 'assistant' | 'system'
  final String content;
  final List<ContextAttachment> attachments;
  final DateTime timestamp;

  const AiChatMessage({
    required this.id,
    required this.role,
    required this.content,
    this.attachments = const [],
    required this.timestamp,
  });
}

class AiChatSession {
  final String id;
  final String title;
  final String provider;
  final String model;
  final List<AiChatMessage> messages;
  final DateTime createdAt;

  const AiChatSession({
    required this.id,
    required this.title,
    required this.provider,
    required this.model,
    this.messages = const [],
    required this.createdAt,
  });
}
