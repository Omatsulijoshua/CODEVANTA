class PromptSanitizationResult {
  final String sanitizedText;
  final bool hasInjectionRisk;
  final int strippedSecretsCount;

  const PromptSanitizationResult({
    required this.sanitizedText,
    required this.hasInjectionRisk,
    required this.strippedSecretsCount,
  });
}

class PromptSanitizer {
  static PromptSanitizationResult sanitize(String prompt) {
    var text = prompt;
    int count = 0;

    final tokenPatterns = [
      RegExp(r'sk-[a-zA-Z0-9_\-]{20,}'),
      RegExp(r'ghp_[a-zA-Z0-9]{36}'),
      RegExp(r'bearer\s+[a-zA-Z0-9\._\-]+', caseSensitive: false),
    ];

    for (final pattern in tokenPatterns) {
      final matches = pattern.allMatches(text);
      if (matches.isNotEmpty) {
        count += matches.length;
        text = text.replaceAll(pattern, '[REDACTED_SECRET_TOKEN]');
      }
    }

    final injectionPatterns = [
      RegExp(r'ignore\s+previous\s+instructions', caseSensitive: false),
      RegExp(r'reveal\s+system\s+prompt', caseSensitive: false),
    ];

    final hasRisk = injectionPatterns.any((p) => p.hasMatch(prompt));

    return PromptSanitizationResult(
      sanitizedText: text,
      hasInjectionRisk: hasRisk,
      strippedSecretsCount: count,
    );
  }
}
