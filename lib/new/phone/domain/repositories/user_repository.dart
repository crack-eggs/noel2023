
import '../../data/models/topup_history_model.dart';
import '../../data/models/user_model.dart';

abstract class UserRepository {

  Future<void> signInGoogle();
  Future<void> createUser(UserModel user);
  Future<void> updateScore(int score);
  Future<void> updateHammers(int hammers);
  Future<void> fetchUser();
  Future<void> topup(TopUpHistoryModel model);
}
