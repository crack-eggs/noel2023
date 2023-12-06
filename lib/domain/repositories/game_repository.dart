import '../../data/models/user_model.dart';
import '../entities/game.dart';

abstract class GameRepository {
  Future<List<UserModel>?> getLeaderBoard();

  Future<void> createMatch(String matchId);

  Future<bool> checkGameValidation(String id);

  Future<void> markGameAsDone(String matchId);
}
