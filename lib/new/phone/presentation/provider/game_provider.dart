import 'package:flutter/material.dart';

import '../../domain/entities/game.dart';

class GameProvider extends ChangeNotifier {
  Game? _game;

  Game? get game => _game;

  void setGame(Game newGame) {
    _game = newGame;
    notifyListeners();
  }
}
