import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/providers/game_provider.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: game.board.nbColumns,
      ),
      itemCount: game.board.nbColumns * game.board.nbRows,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: const BorderSide(color: Colors.black),
              left: const BorderSide(color: Colors.black),
              right: game.board.isRightWall(index) ? const BorderSide(color: Colors.black) : BorderSide.none,
              bottom: game.board.isBottomWall(index) ? const BorderSide(color: Colors.black) : BorderSide.none,
            ),
          ),
          child: Center(
            child: Text(
              index.toString(),
            ),
          ),
        );
      },
    );
  }
}
