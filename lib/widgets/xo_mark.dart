import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictatctoe/constants/colors.dart';

class XoMark extends StatelessWidget {
  const XoMark({
    super.key,
    required this.mark,
    this.size = 40,
    this.animate = true,
  });

  final String mark;
  final double size;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    if (mark.isEmpty) return const SizedBox.shrink();

    final isX = mark == 'X';
    final color = isX ? AppColors.purple : AppColors.blue;

    final text = Text(
      mark,
      style: GoogleFonts.orbitron(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: color,
        shadows: [
          Shadow(color: color.withValues(alpha: 0.55), blurRadius: 12),
        ],
      ),
    );

    if (!animate) return text;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: text,
    );
  }
}

class ClashLogo extends StatelessWidget {
  const ClashLogo({super.key, this.size = 120});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _ClashLogoPainter()),
    );
  }
}

class _ClashLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..shader = SweepGradient(
        colors: [
          AppColors.purple,
          AppColors.accent,
          AppColors.blue,
          AppColors.purple,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, ring);

    final fill = Paint()..color = AppColors.boxGrey.withValues(alpha: 0.85);
    canvas.drawCircle(center, radius * 0.82, fill);

    final xPaint = Paint()
      ..color = AppColors.purple
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final oPaint = Paint()
      ..color = AppColors.blue
      ..strokeWidth = size.width * 0.07
      ..style = PaintingStyle.stroke;

    final left = size.width * 0.28;
    final right = size.width * 0.48;
    final top = size.height * 0.32;
    final bottom = size.height * 0.68;

    canvas.drawLine(Offset(left, top), Offset(right, bottom), xPaint);
    canvas.drawLine(Offset(right, top), Offset(left, bottom), xPaint);

    canvas.drawCircle(
      Offset(size.width * 0.68, size.height * 0.5),
      size.width * 0.13,
      oPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
