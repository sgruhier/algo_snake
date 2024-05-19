import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:flutter_snake/widgets/Tile.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: game.board.nbColumns,
      ),
      itemCount: game.board.nbColumns * game.board.nbRows,
      itemBuilder: (BuildContext context, int index) {
        var x = index % game.board.nbColumns;
        var y = index ~/ game.board.nbColumns;
        var tileType = game.getTileType(x, y);
        return Tile(
          tileType: tileType,
          color: game.isGameOver && tileType.isSnake ? Colors.red : null,
        );
      },
    );
  }
}
