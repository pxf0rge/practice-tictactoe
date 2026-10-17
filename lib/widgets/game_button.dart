import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/theme.dart';

enum GameButtonVariant { primary, secondary, ghost, accent }

class GameButton extends StatefulWidget {
  const GameButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GameButtonVariant.primary,
    this.icon,
    this.height = 52,
  });

  final String label;
  final VoidCallback? onPressed;
  final GameButtonVariant variant;
  final IconData? icon;
  final double height;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        child: AnimatedOpacity(
          opacity: enabled ? 1 : 0.45,
          duration: const Duration(milliseconds: 150),
          child: Container(
            width: double.infinity,
            height: widget.height,
            decoration: _decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: _foreground, size: 20),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.label.toUpperCase(),
                  style: AppTheme.title.copyWith(
                    fontSize: 13,
                    letterSpacing: 1.4,
                    color: _foreground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _decoration {
    switch (widget.variant) {
      case GameButtonVariant.primary:
        return BoxDecoration(
          gradient: AppColors.ctaGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        );
      case GameButtonVariant.secondary:
        return BoxDecoration(
          gradient: AppColors.xGlow,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.22),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        );
      case GameButtonVariant.accent:
        return BoxDecoration(
          gradient: AppColors.oGlow,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.blue.withValues(alpha: 0.22),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        );
      case GameButtonVariant.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.panelBorder, width: 1.4),
        );
    }
  }

  Color get _foreground {
    switch (widget.variant) {
      case GameButtonVariant.primary:
        return AppColors.bgDeep;
      case GameButtonVariant.secondary:
      case GameButtonVariant.accent:
        return Colors.white;
      case GameButtonVariant.ghost:
        return AppColors.grey;
    }
  }
}
