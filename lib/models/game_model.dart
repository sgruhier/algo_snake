// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/tile_model.dart';

class GameModel {
  BoardModel board;
  List<TileModel> snake;
  TileModel? food;
  bool gameOver;
  bool isPlaying;

  GameModel({
    required this.board,
    required this.snake,
    this.food,
    this.gameOver = false,
    this.isPlaying = false,
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
      var snakeTile = snake.firstWhere((element) => element.x == x && element.y == y);
      if (snakeTile == snake.last) {
        return TileType.snakeHead;
      } else if (snakeTile == snake.first) {
        return TileType.snakeTail;
      } else {
        return TileType.snakeBody;
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
    bool? gameOver,
    bool? isPlaying,
  }) {
    return GameModel(
      board: board ?? this.board,
      snake: snake ?? this.snake,
      food: food ?? this.food,
      gameOver: gameOver ?? this.gameOver,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
