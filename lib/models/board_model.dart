import 'package:flutter_snake/models/tile_model.dart';

class BoardModel {
  List<TileModel> squares = [];
  final int nbRows;
  final int nbColumns;

  BoardModel({required this.nbRows, required this.nbColumns}) {
    for (int i = 0; i < nbRows; i++) {
      for (int j = 0; j < nbColumns; j++) {
        squares.add(TileModel(x: i, y: j));
      }
    }
  }
}
