import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/theme.dart';
import 'package:tictatctoe/data/gameLog.dart';
import 'package:tictatctoe/widgets/game_panel.dart';
import 'package:tictatctoe/widgets/game_scaffold.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    final entries = games.values.cast<Gamelog>().toList().reversed.toList();

    return GameScaffold(
      appBar: AppBar(
        title: const Text('HISTORY'),
        actions: [
          if (entries.isNotEmpty)
            IconButton(
              tooltip: 'Clear history',
              onPressed: () {
                games.clear();
                setState(() {});
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Match log', style: AppTheme.display.copyWith(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            entries.isEmpty
                ? 'No battles yet. Go claim the board.'
                : '${entries.length} recorded match${entries.length == 1 ? '' : 'es'}',
            style: AppTheme.muted.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: entries.isEmpty
                ? _EmptyHistory()
                : ListView.separated(
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final game = entries[index];
                      return _HistoryCard(
                        gameType: game.gameType,
                        result: game.result,
                        date: game.date,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GamePanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sports_esports_outlined,
              size: 42,
              color: AppColors.lightGrey,
            ),
            const SizedBox(height: 12),
            Text('Arena is quiet',
                style: AppTheme.title.copyWith(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              'Finish a match to see it here.',
              style: AppTheme.muted.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.gameType,
    required this.result,
    required this.date,
  });

  final int gameType;
  final String result;
  final String date;

  static const _gameTypes = ['VS Friend', 'VS AI'];

  Color get _resultColor {
    if (result.contains('Draw')) return AppColors.accent;
    if (result.contains('AI')) return AppColors.blue;
    if (result.contains('(O)')) return AppColors.blue;
    return AppColors.purple;
  }

  @override
  Widget build(BuildContext context) {
    final typeLabel = (gameType >= 0 && gameType < _gameTypes.length)
        ? _gameTypes[gameType]
        : 'Unknown';

    return GamePanel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _resultColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              gameType == 1
                  ? Icons.smart_toy_outlined
                  : Icons.groups_2_outlined,
              color: _resultColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result, style: AppTheme.title.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(
                  '$typeLabel  ·  $date',
                  style: AppTheme.muted.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
