import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/tile_model.dart';

class GameModel {
  final BoardModel board;
  final List<TileModel> snake;
  TileModel? food;

  GameModel({required this.board, this.snake = const [], this.food});
}
