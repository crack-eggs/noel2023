import '../../data/models/settings.dart';
import '../../data/models/user_model.dart';

abstract class GameRepository {
  Future<List<UserModel>?> getLeaderBoard();

  Future<void> createMatch(String matchId);

  Future<bool> checkGameValidation(String id);

  Future<void> markGameAsDone(String matchId);

  Future<Settings?> getSettings();

  Future<void> updateJackpot({int? quantity});

  Future<void> updateGame(
      {required String matchId, required Map<String, dynamic> payload});
}
