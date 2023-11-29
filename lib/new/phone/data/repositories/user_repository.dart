
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient supabaseClient;

  UserRepositoryImpl(this.supabaseClient);

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
  }

  @override
  Future<void> addUser(UserEntity user) async {
  }
}
