// lib/data/repositories/leaderboard_repository_impl.dart
import 'package:noel/new/phone/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final SupabaseClient supabaseClient;

  LeaderboardRepositoryImpl(this.supabaseClient);

  @override
  Future<List<UserModel>> getLeaderboard() async {
    // Implement Supabase query to get leaderboard
    final response = await supabaseClient
        .from('users')
        .select('*')
        .order('score', ascending: false)
        .limit(10)
        .execute();
    final List<UserModel> leaderboard = (response.data as List<dynamic>)
        .map((data) => UserModel.fromJson(data))
        .toList();

    return leaderboard;
  }
}
