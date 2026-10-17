import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/functions/emptyBoxes.dart';
import 'package:tictatctoe/constants/functions/findBestMove.dart';
import 'package:tictatctoe/constants/functions/findWinner.dart';
import 'package:tictatctoe/constants/functions/makeMove.dart';
import 'package:tictatctoe/constants/functions/navigator.dart';
import 'package:tictatctoe/constants/theme.dart';
import 'package:tictatctoe/data/gameLog.dart';
import 'package:tictatctoe/pages/home.dart';
import 'package:tictatctoe/widgets/game_button.dart';
import 'package:tictatctoe/widgets/game_panel.dart';
import 'package:tictatctoe/widgets/game_scaffold.dart';
import 'package:tictatctoe/widgets/xo_mark.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.gameType, required this.isAiMode});

  final int gameType;
  final bool isAiMode;

  @override
  State<GamePage> createState() => _GamePageState(gameType, isAiMode);
}

class _GamePageState extends State<GamePage> {
  _GamePageState(this.gameType, this.isAIMode);

  final int gameType;
  final bool isAIMode;

  List<String> boxes = List.filled(9, '');
  String winner = '';

  int filledBoxes = 0;
  bool gameEnded = false;
  bool playerWon = false;
  bool isTurnX = true;

  int p1Score = 0;
  int p2Score = 0;
  int ties = 0;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return GameScaffold(
      appBar: AppBar(
        title: Text(isTurnX ? 'TURN X' : 'TURN O'),
        actions: [
          IconButton(
            tooltip: 'Reset board',
            onPressed: () => setState(resetGame),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      body: Column(
        children: [
          _TurnBanner(isTurnX: isTurnX, isAiMode: isAIMode),
          const SizedBox(height: 18),
          Expanded(child: Center(child: _board())),
          const SizedBox(height: 18),
          _scoreBoard(),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            child: gameEnded
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _winBox(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  String _getDate() {
    final now = DateTime.now();
    final fixedMinute = now.minute < 10 ? '0${now.minute}' : '${now.minute}';
    return '${months[now.month - 1]} ${now.day}, ${now.hour}:$fixedMinute';
  }

  Widget _board() {
    return AspectRatio(
      aspectRatio: 1,
      child: GamePanel(
        padding: const EdgeInsets.all(12),
        borderColor: AppColors.accent.withValues(alpha: 0.22),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => _onCellTap(index),
            child: _getBox(index),
          ),
        ),
      ),
    );
  }

  void _onCellTap(int index) {
    setState(() {
      if (boxes[index] == '' && !gameEnded) {
        isTurnX
            ? makeMove(boxes, index, 'X')
            : (isAIMode ? () {} : makeMove(boxes, index, 'O'));

        winner = findWinner(boxes, filledBoxes);

        if (winner != 'X' && winner != 'O') {
          if (isAIMode) {
            int bestMove = findBestMove(boxes, filledBoxes);

            if (bestMove > 0) {
              while (boxes[bestMove] != '') {
                bestMove = findBestMove(boxes, filledBoxes);
              }

              makeMove(boxes, bestMove, 'O');
              winner = findWinner(boxes, filledBoxes);
              if (winner != '') setWin(winner);
            } else {
              final emptyBoxes = getAvailableMoves(boxes);

              if (emptyBoxes.isNotEmpty) {
                int randomIndex = Random().nextInt(emptyBoxes.length);

                while (boxes[randomIndex] != '') {
                  randomIndex = findBestMove(boxes, filledBoxes);
                }

                makeMove(boxes, randomIndex, 'O');
                winner = findWinner(boxes, filledBoxes);
                if (winner != '') setWin(winner);
              }
            }
          }

          if (!isAIMode) isTurnX = !isTurnX;
          isAIMode ? filledBoxes += 2 : filledBoxes++;
        } else {
          setWin(winner);
        }
      }
    });
  }

  void setWin(String winner) {
    gameEnded = true;

    switch (winner) {
      case 'X':
        p1Score++;
        games.add(Gamelog(gameType, 'Player (X) Won', _getDate()));
        break;
      case 'O':
        p2Score++;
        games.add(
          Gamelog(
            gameType,
            isAIMode ? 'AI (O) Won' : 'Player (O) Won',
            _getDate(),
          ),
        );
        break;
      case 'Draw':
        ties++;
        games.add(Gamelog(gameType, 'Draw', _getDate()));
        break;
    }
  }

  Widget _getBox(int index) {
    final mark = boxes[index];
    final isX = mark == 'X';
    final accent = mark.isEmpty
        ? AppColors.panelBorder
        : (isX ? AppColors.purple : AppColors.blue);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: mark.isEmpty
            ? Colors.white.withValues(alpha: 0.04)
            : accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accent.withValues(alpha: mark.isEmpty ? 0.2 : 0.55),
        ),
      ),
      child: Center(
        child: XoMark(mark: mark, size: 34),
      ),
    );
  }

  void resetGame() {
    boxes = List.filled(9, '');
    gameEnded = false;
    if (!isAIMode) isTurnX = !isTurnX;
    playerWon = false;
    filledBoxes = 0;
    winner = '';
  }

  Widget _winBox() {
    final isDraw = winner == 'Draw';
    final title = isDraw
        ? 'DRAW'
        : winner == 'X'
            ? 'X WINS'
            : (isAIMode ? 'AI WINS' : 'O WINS');
    final accent = isDraw
        ? AppColors.accent
        : (winner == 'X' ? AppColors.purple : AppColors.blue);

    return GamePanel(
      borderColor: accent.withValues(alpha: 0.4),
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.display.copyWith(fontSize: 22, color: accent),
          ),
          const SizedBox(height: 4),
          Text(
            isDraw ? 'Even match. Rematch?' : 'Arena claimed. Rematch?',
            style: AppTheme.muted.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          GameButton(
            label: 'Play Again',
            icon: Icons.replay_rounded,
            onPressed: () => setState(resetGame),
          ),
          const SizedBox(height: 10),
          GameButton(
            label: 'Back to Home',
            variant: GameButtonVariant.ghost,
            onPressed: () => Nav().gotoPage(const HomePage(), context),
          ),
        ],
      ),
    );
  }

  Widget _scoreBoard() {
    return GamePanel(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _ScoreCell(
              label: 'Player X',
              value: p1Score,
              color: AppColors.purple,
            ),
          ),
          Container(
            width: 1,
            height: 36,
            color: AppColors.panelBorder,
          ),
          Expanded(
            child: _ScoreCell(
              label: 'Ties',
              value: ties,
              color: AppColors.accent,
            ),
          ),
          Container(
            width: 1,
            height: 36,
            color: AppColors.panelBorder,
          ),
          Expanded(
            child: _ScoreCell(
              label: gameType == 0 ? 'Player O' : 'AI O',
              value: p2Score,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class _TurnBanner extends StatelessWidget {
  const _TurnBanner({required this.isTurnX, required this.isAiMode});

  final bool isTurnX;
  final bool isAiMode;

  @override
  Widget build(BuildContext context) {
    final color = isTurnX ? AppColors.purple : AppColors.blue;
    final label = isTurnX
        ? 'Your move — X'
        : (isAiMode ? 'AI thinking — O' : 'Your move — O');

    return GamePanel(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.55), blurRadius: 8),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(label, style: AppTheme.body.copyWith(fontSize: 16)),
          const Spacer(),
          XoMark(mark: isTurnX ? 'X' : 'O', size: 18, animate: false),
        ],
      ),
    );
  }
}

class _ScoreCell extends StatelessWidget {
  const _ScoreCell({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: AppTheme.muted.copyWith(fontSize: 13)),
        const SizedBox(height: 2),
        Text(
          '$value',
          style: AppTheme.title.copyWith(fontSize: 22, color: color),
        ),
      ],
    );
  }
}
