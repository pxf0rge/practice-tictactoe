import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/functions/navigator.dart';
import 'package:tictatctoe/constants/theme.dart';
import 'package:tictatctoe/pages/gameMode.dart';
import 'package:tictatctoe/widgets/game_button.dart';
import 'package:tictatctoe/widgets/game_scaffold.dart';
import 'package:tictatctoe/widgets/xo_mark.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GameScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      body: Column(
        children: [
          const Spacer(flex: 2),
          const ClashLogo(size: 140),
          const SizedBox(height: 28),
          Text(
            'XOCLASH',
            style: AppTheme.display.copyWith(fontSize: 36),
          ),
          const SizedBox(height: 8),
          Text(
            'Pick a side. Claim the board.',
            style: AppTheme.muted.copyWith(fontSize: 16, letterSpacing: 0.4),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _MarkChip(label: 'X', color: AppColors.purple),
              const SizedBox(width: 12),
              Text('VS', style: AppTheme.title.copyWith(fontSize: 12)),
              const SizedBox(width: 12),
              _MarkChip(label: 'O', color: AppColors.blue),
            ],
          ),
          const Spacer(flex: 3),
          GameButton(
            label: 'Start Game',
            icon: Icons.play_arrow_rounded,
            onPressed: () => Nav().gotoPage(GameModePage(), context),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class _MarkChip extends StatelessWidget {
  const _MarkChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: AppTheme.title.copyWith(color: color, fontSize: 18),
      ),
    );
  }
}
