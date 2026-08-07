import 'package:flutter/material.dart';
import 'core/theme/codevanta_theme.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const CodeVantaApp());
}

class CodeVantaApp extends StatelessWidget {
  const CodeVantaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeVanta',
      debugShowCheckedModeBanner: false,
      theme: CodeVantaTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
