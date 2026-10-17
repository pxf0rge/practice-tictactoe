import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/colors.dart';

class GameScaffold extends StatelessWidget {
  const GameScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.padding,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.arenaGradient),
      child: Stack(
        children: [
          const Positioned.fill(child: _ArenaGlow()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: SafeArea(
              child: padding == null
                  ? body
                  : Padding(padding: padding!, child: body),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArenaGlow extends StatelessWidget {
  const _ArenaGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(painter: _ArenaPainter()),
    );
  }
}

class _ArenaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final coral = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.purple.withValues(alpha: 0.18),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.15, size.height * 0.2),
        radius: size.width * 0.55,
      ));

    final cyan = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.blue.withValues(alpha: 0.14),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.9, size.height * 0.75),
        radius: size.width * 0.5,
      ));

    canvas.drawRect(Offset.zero & size, coral);
    canvas.drawRect(Offset.zero & size, cyan);

    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    const step = 36.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
