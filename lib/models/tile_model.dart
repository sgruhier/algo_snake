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
  food,
}

class TileModel {
  final int x;
  final int y;
  TileModel({required this.x, required this.y});
}
