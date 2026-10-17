import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/theme.dart';
import 'package:tictatctoe/widgets/game_panel.dart';
import 'package:tictatctoe/widgets/game_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool gameSound = myBox.get('gameSound') ?? true;
  final List<String> difficulties = ['Easy', 'Medium', 'Hard'];
  int selectedIndex = myBox.get('aiDifficulty') ?? 0;

  @override
  Widget build(BuildContext context) {
    return GameScaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tune the arena',
              style: AppTheme.display.copyWith(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            'Sound and AI challenge level.',
            style: AppTheme.muted.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 24),
          GamePanel(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    gameSound
                        ? Icons.volume_up_rounded
                        : Icons.volume_off_rounded,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Game Sound',
                          style: AppTheme.title.copyWith(fontSize: 15)),
                      Text(
                        gameSound ? 'Enabled' : 'Muted',
                        style: AppTheme.muted.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: gameSound,
                  onChanged: (value) {
                    setState(() {
                      gameSound = value;
                      myBox.put('gameSound', gameSound);
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GamePanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Difficulty',
                    style: AppTheme.title.copyWith(fontSize: 15)),
                const SizedBox(height: 4),
                Text(
                  'How hard should the machine fight?',
                  style: AppTheme.muted.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    for (int i = 0; i < difficulties.length; i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      Expanded(
                          child: _DifficultyChip(
                        label: difficulties[i],
                        selected: selectedIndex == i,
                        onTap: () {
                          setState(() {
                            selectedIndex = i;
                            myBox.put('aiDifficulty', i);
                          });
                        },
                      )),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected ? AppColors.ctaGradient : null,
          color: selected ? null : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.transparent : AppColors.panelBorder,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: AppTheme.title.copyWith(
            fontSize: 11,
            letterSpacing: 1.1,
            color: selected ? AppColors.bgDeep : AppColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
