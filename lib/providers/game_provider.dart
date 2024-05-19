import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/models/board_model.dart';
import 'package:flutter_snake/models/game_model.dart';

class GameNotifier extends StateNotifier<GameModel> {
  GameNotifier()
      : super(
          GameModel(
            board: BoardModel(nbRows: 10, nbColumns: 10),
          ),
        );

  void start({required int nbRows, required int nbColumns}) {
    var game = GameModel(
      board: BoardModel(nbRows: 10, nbColumns: 10),
    );
    game.init();

    state = game;
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameModel>((ref) => GameNotifier());
