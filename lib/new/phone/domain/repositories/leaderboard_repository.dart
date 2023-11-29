
import '../../data/models/user_model.dart';

abstract class LeaderboardRepository {
  Future<List<UserModel>> getLeaderboard();
}
