import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/game_model.dart';
import 'package:flutter_snake/models/tile_model.dart';

class GameNotifier extends StateNotifier<GameModel> {
  GameNotifier()
      : super(
          GameModel(
            board: BoardModel(nbRows: 10, nbColumns: 10),
          ),
        );

  void start({required int nbRows, required int nbColumns}) {
    var game = GameModel(
      board: BoardModel(nbRows: 10, nbColumns: 10),
    );
    game.init();

    state = game;
  }

  void moveSnake(Direction direction) {
    var snake = state.snake;
    snake.removeAt(0);
    var head = state.snake.last;
    late TileModel newHead;
    switch (direction) {
      case Direction.up:
        newHead = TileModel(x: head.x, y: head.y - 1);
        break;
      case Direction.down:
        newHead = TileModel(x: head.x, y: head.y + 1);
        break;
      case Direction.right:
        newHead = TileModel(x: head.x + 1, y: head.y);
        break;
      case Direction.left:
        newHead = TileModel(x: head.x - 1, y: head.y);
        break;
    }
    snake.add(newHead);

    state = state.copyWith(snake: snake);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameModel>((ref) => GameNotifier());
