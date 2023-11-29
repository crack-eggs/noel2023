import '../entities/game.dart';

abstract class GameRepository {
  Future<void> startGame(String uuid);

  Future<Game?> getGame(String uuid);
}
