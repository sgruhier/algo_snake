import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/square_model.dart';

class GameModel {
  final BoardModel board;
  final List<SquareModel> snake;

  GameModel({required this.board, this.snake = const []});
}
