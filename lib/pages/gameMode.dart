import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/functions/navigator.dart';
import 'package:tictatctoe/constants/theme.dart';
import 'package:tictatctoe/pages/game.dart';
import 'package:tictatctoe/pages/leaderBoard.dart';
import 'package:tictatctoe/pages/settings.dart';
import 'package:tictatctoe/widgets/game_button.dart';
import 'package:tictatctoe/widgets/game_panel.dart';
import 'package:tictatctoe/widgets/game_scaffold.dart';

class GameModePage extends StatelessWidget {
  GameModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GameScaffold(
      appBar: AppBar(
        title: const Text('ARENA'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => Nav().gotoPage(const SettingsPage(), context),
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose your battle',
              style: AppTheme.display.copyWith(fontSize: 24)),
          const SizedBox(height: 6),
          Text(
            'One board. Two marks. No mercy.',
            style: AppTheme.muted.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 28),
          _ModeCard(
            title: 'VS AI',
            subtitle: 'Challenge the machine',
            icon: Icons.smart_toy_outlined,
            accent: AppColors.purple,
            onTap: () {
              Nav().gotoPage(
                const GamePage(gameType: 1, isAiMode: true),
                context,
              );
            },
          ),
          const SizedBox(height: 14),
          _ModeCard(
            title: 'VS FRIEND',
            subtitle: 'Pass & play locally',
            icon: Icons.groups_2_outlined,
            accent: AppColors.blue,
            onTap: () {
              Nav().gotoPage(
                const GamePage(gameType: 0, isAiMode: false),
                context,
              );
            },
          ),
          const Spacer(),
          GameButton(
            label: 'Match History',
            variant: GameButtonVariant.ghost,
            icon: Icons.history_rounded,
            onPressed: () => Nav().gotoPage(LeaderboardPage(), context),
          ),
        ],
      ),
    );
  }
}

class _ModeCard extends StatefulWidget {
  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  @override
  State<_ModeCard> createState() => _ModeCardState();
}

class _ModeCardState extends State<_ModeCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        child: GamePanel(
          borderColor: widget.accent.withValues(alpha: 0.35),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: widget.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(widget.icon, color: widget.accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTheme.title.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: AppTheme.muted.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.lightGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
