import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

enum LogoStyle { iconOnly, wordmarkOnly, horizontal }

class CodeVantaLogo extends StatelessWidget {
  final double size;
  final LogoStyle style;

  const CodeVantaLogo({
    super.key,
    this.size = 40,
    this.style = LogoStyle.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: CodeVantaColors.electricViolet,
        borderRadius: BorderRadius.circular(size * 0.24),
        boxShadow: [
          BoxShadow(
            color: CodeVantaColors.electricViolet.withValues(alpha: 0.35),
            blurRadius: size * 0.3,
            spreadRadius: 2,
          )
        ],
      ),
      child: CustomPaint(
        painter: _CodeVantaLogoPainter(),
      ),
    );

    if (style == LogoStyle.iconOnly) {
      return iconWidget;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'CODEVANTA',
          style: TextStyle(
            color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
            fontSize: size * 0.45,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
        ),
        Text(
          'MOBILE AI IDE',
          style: TextStyle(
            color: CodeVantaColors.cyanAccent,
            fontSize: size * 0.22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );

    if (style == LogoStyle.wordmarkOnly) {
      return textWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconWidget,
        SizedBox(width: size * 0.3),
        textWidget,
      ],
    );
  }
}

class _CodeVantaLogoPainter extends CustomPainter {
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
