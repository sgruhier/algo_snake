import 'package:flutter_snake/models/tile_model.dart';

class BoardModel {
  List<TileModel> squares = [];
  final int nbRows;
  final int nbColumns;

  BoardModel({required this.nbRows, required this.nbColumns}) {
    for (int i = 0; i < nbColumns; i++) {
      for (int j = 0; j < nbRows; j++) {
        squares.add(
          TileModel(
            x: i,
            y: j,
          ),
        );
      }
    }
  }
}
