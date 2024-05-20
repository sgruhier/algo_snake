// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Direction {
  up,
  down,
  left,
  right,
}

enum TileType {
  empty,

  snakeBodyVertical,
  snakeBodyHorizontal,
  snakeBodyDownLeft,
  snakeBodyDownRight,
  snakeBodyUpLeft,
  snakeBodyUpRight,

  snakeHeadUp,
  snakeHeadRight,
  snakeHeadDown,
  snakeHeadLeft,

  snakeTailUp,
  snakeTailRight,
  snakeTailDown,
  snakeTailLeft,

  food;

  bool get isSnake {
    return this != TileType.empty && this != TileType.food;
  }
}

class TileModel {
  final int x;
  final int y;
  TileModel({required this.x, required this.y});
}
