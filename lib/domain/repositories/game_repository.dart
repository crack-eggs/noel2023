import '../../data/models/user_model.dart';
import '../entities/game.dart';

abstract class GameRepository {
  Future<void> startGame();

  Future<void> getGame();

  Future<void> getGift();

  Future<List<UserModel>?> getLeaderBoard();

}
