import '../entities/user.dart';

abstract class UserRepository {
  Future<UserEntity?> getUserByEmail(String email);
  Future<void> addUser(UserEntity user);
}
