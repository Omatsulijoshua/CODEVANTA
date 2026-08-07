import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../domain/ai_chat_models.dart';

class AiChatRepository {
  final Dio _dio;

  AiChatRepository({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfig.defaultApiBaseUrl,
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
              ),
            );

  Future<AiChatMessage> sendExecution({
    required String provider,
    required String model,
    required String userPrompt,
    List<ContextAttachment> attachments = const [],
  }) async {
    try {
      final response = await _dio.post('/ai-gateway/execute', data: {
        'provider': provider,
        'model': model,
        'messages': [
          {'role': 'user', 'content': userPrompt},
        ],
      });

      final content = response.data['content'] ?? 'AI processing complete.';
      return AiChatMessage(
        id: response.data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        role: 'assistant',
        content: content,
        timestamp: DateTime.now(),
      );
    } on DioException catch (_) {
      return AiChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: 'assistant',
        content: '[Offline / Fallback Response]: Simulated AI response for prompt: "$userPrompt"',
        timestamp: DateTime.now(),
      );
    }
  }
}
