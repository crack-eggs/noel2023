
import 'package:google_sign_in_platform_interface/src/types.dart';

import '../../data/models/user_model.dart';

abstract class UserRepository {

  Future<void> signInGoogle({GoogleSignInUserData? userData});
  Future<void> createUser(UserModel user);
  Future<void> updateScore(int score);
  Future<void> updateHammers(int hammers);
  Future<void> fetchUser();
  Future<void> topup(int quantity);
}
