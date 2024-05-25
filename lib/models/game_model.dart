// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/tile_model.dart';

class GameModel {
  BoardModel board;
  List<TileModel> snake;
  TileModel? food;
  bool isGameOver;
  bool isPlaying;
  bool isPaused;
  Direction direction;
  int score;

  GameModel({
    required this.board,
    required this.snake,
    this.direction = Direction.left,
    this.food,
    this.isGameOver = false,
    this.isPlaying = false,
    this.isPaused = true,
    this.score = 0,
  });

  void start() {
    var middleX = (board.nbColumns / 2).floor() + 3;
    var middleY = (board.nbRows / 2).floor();
    snake = [
      TileModel(
        x: middleX,
        y: middleY,
      ),
      TileModel(
        x: middleX - 1,
        y: middleY,
      ),
      TileModel(
        x: middleX - 2,
        y: middleY,
      ),
      TileModel(
        x: middleX - 3,
        y: middleY,
      ),
    ];

    generateFood();
    isPlaying = true;
    score = 0;
  }

  void generateFood() {
    var emptyTiles = [...board.squares];
    // Remove snake tiles from empty tiles
    for (var element in snake) {
      emptyTiles.removeWhere((tile) => tile.x == element.x && tile.y == element.y);
    }
    // Remove food tile from empty tiles
    if (food != null) {
      emptyTiles.removeWhere((tile) => tile.x == food!.x && tile.y == food!.y);
    }

    // Pick a random empty tile for food
    var availableTile = emptyTiles[Random().nextInt(emptyTiles.length)];
    food = TileModel(x: availableTile.x, y: availableTile.y);
  }

  TileType getTileType(int x, int y) {
    if (snake.any((element) => element.x == x && element.y == y)) {
      var snakeTile = snake.indexWhere((element) => element.x == x && element.y == y);
      var previous = snakeTile == 0 ? null : snake[snakeTile - 1];
      var next = snakeTile == snake.length - 1 ? null : snake[snakeTile + 1];

      // Tails of the snake
      if (snakeTile == 0) {
        if (next!.x > x) {
          return TileType.snakeTailLeft;
        } else if (next.x < x) {
          return TileType.snakeTailRight;
        } else if (next.y > y) {
          return TileType.snakeTailUp;
        } else {
          return TileType.snakeTailDown;
        }
      }
      // Head of the snake
      else if (snakeTile == snake.length - 1) {
        if (previous!.x > x) {
          return TileType.snakeHeadLeft;
        } else if (previous.x < x) {
          return TileType.snakeHeadRight;
        } else if (previous.y > y) {
          return TileType.snakeHeadUp;
        } else {
          return TileType.snakeHeadDown;
        }
      }
      // Body of the snake
      else {
        if (previous!.x < x && next!.x > x || next!.x < x && previous.x > x) {
          return TileType.snakeBodyHorizontal;
        } else if (previous.y < y && next.y > y || next.y < y && previous.y > y) {
          return TileType.snakeBodyVertical;
        } else if (previous.x < x && next.y > y || next.x < x && previous.y > y) {
          return TileType.snakeBodyDownRight;
        } else if (previous.x < x && next.y < y || next.x < x && previous.y < y) {
          return TileType.snakeBodyUpRight;
        } else if (previous.x > x && next.y > y || next.x > x && previous.y > y) {
          return TileType.snakeBodyDownLeft;
        } else if (previous.x > x && next.y < y || next.x > x && previous.y < y) {
          return TileType.snakeBodyUpLeft;
        } else {
          return TileType.snakeBodyHorizontal;
        }
      }
    } else if (food?.x == x && food?.y == y) {
      return TileType.food;
    } else {
      return TileType.empty;
    }
  }

  GameModel copyWith({
    BoardModel? board,
    List<TileModel>? snake,
    TileModel? food,
    bool? isGameOver,
    bool? isPlaying,
    bool? isPaused,
    Direction? direction,
    int? score,
  }) {
    return GameModel(
      board: board ?? this.board,
      snake: snake ?? this.snake,
      food: food ?? this.food,
      isGameOver: isGameOver ?? this.isGameOver,
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      direction: direction ?? this.direction,
      score: score ?? this.score,
    );
  }
}
