// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Direction {
  up,
  down,
  left,
  right,
}

enum TileType {
  empty,
  snakeBody,
  snakeHead,
  snakeTail,
  food;

  bool get isSnake {
    return this == TileType.snakeBody || this == TileType.snakeHead || this == TileType.snakeTail;
  }
}

class TileModel {
  final int x;
  final int y;
  TileModel({required this.x, required this.y});

  int index() {
    return x + y * 10;
  }
}
