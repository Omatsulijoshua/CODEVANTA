import 'package:flutter/material.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/codevanta_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CodeVantaColors.darkGraphite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CodeVanta Geometric Logo Symbol
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: CodeVantaColors.electricViolet,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: CodeVantaColors.electricViolet.withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: CustomPaint(
                painter: CodeVantaLogoPainter(),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'CODEVANTA',
              style: TextStyle(
                color: CodeVantaColors.textDarkPrimary,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 3.0,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              AppConfig.tagline,
              style: TextStyle(
                color: CodeVantaColors.cyanAccent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(CodeVantaColors.cyanAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeVantaLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(size.width * 0.28, size.height * 0.28)
      ..lineTo(size.width * 0.52, size.height * 0.28)
      ..lineTo(size.width * 0.52, size.height * 0.38)
      ..lineTo(size.width * 0.40, size.height * 0.38)
      ..lineTo(size.width * 0.50, size.height * 0.62)
      ..lineTo(size.width * 0.40, size.height * 0.62)
      ..close();

    final path2 = Path()
      ..moveTo(size.width * 0.56, size.height * 0.28)
      ..lineTo(size.width * 0.68, size.height * 0.28)
      ..lineTo(size.width * 0.52, size.height * 0.72)
      ..lineTo(size.width * 0.40, size.height * 0.72)
      ..close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
