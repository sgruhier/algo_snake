import 'package:flutter_snake/models/square_model.dart';

class BoardModel {
  List<SquareModel> squares = [];
  final int nbRows;
  final int nbColumns;

  BoardModel({required this.nbRows, required this.nbColumns}) {
    for (int i = 0; i < nbRows; i++) {
      for (int j = 0; j < nbColumns; j++) {
        squares.add(SquareModel(x: i, y: j));
      }
    }
  }
  bool isRightWall(int index) {
    return index % nbColumns == nbColumns - 1;
  }

  bool isBottomWall(int index) {
    return index >= nbColumns * (nbRows - 1);
  }
}
