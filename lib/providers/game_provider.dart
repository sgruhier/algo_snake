import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/game_model.dart';
import 'package:flutter_snake/models/tile_model.dart';

const NB_COLUMNS = 10;
const NB_ROWS = 10;

class GameNotifier extends StateNotifier<GameModel> {
  GameNotifier()
      : super(
          GameModel(
            board: BoardModel(nbRows: NB_ROWS, nbColumns: NB_COLUMNS),
            snake: [],
          ),
        );

  void start() {
    var game = GameModel(
      board: BoardModel(nbRows: NB_ROWS, nbColumns: NB_COLUMNS),
      snake: [],
    );
    game.start();

    state = game;
  }

  bool isGameOver() {
    var snake = state.snake;
    var board = state.board;

    var head = snake.last;
    // Check if snake hits the wall
    if (head.x < 0 || head.x >= board.nbColumns || head.y < 0 || head.y >= board.nbRows) {
      return true;
    }
    // Check if snake hits itself
    if (snake.any((element) => element.x == head.x && element.y == head.y && element != head)) {
      return true;
    }
    return false;
  }

  void setSnakeDirection(Direction direction) {
    state = state.copyWith(direction: direction);
  }

  void incrementScore() {
    state = state.copyWith(score: state.score + 1);
  }

  void moveSnake() {
    if (state.isPlaying == false) {
      return;
    }
    var snake = state.snake;
    var head = state.snake.last;
    late TileModel newHead;
    switch (state.direction) {
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

    // check if new head eats food, add don't remove snake tail tile and generate new food
    var increment = 0;
    if (state.food != null && state.food!.x == newHead.x && state.food!.y == newHead.y) {
      snake.add(newHead);
      state.generateFood();
      increment++;
    } else {
      snake.removeAt(0);
      snake.add(newHead);
    }

    state = state.copyWith(
      snake: snake,
      isGameOver: isGameOver(),
      isPlaying: !isGameOver(),
      score: state.score + increment,
    );
  }

  void togglePause() {
    state = state.copyWith(isPaused: !state.isPaused);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameModel>((ref) => GameNotifier());
