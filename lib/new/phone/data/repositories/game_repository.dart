import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/game_repository.dart';
import '../models/user_model.dart';

class GameRepositoryImpl implements GameRepository {
  final SupabaseClient supabaseClient;

  GameRepositoryImpl(this.supabaseClient);

  @override
  Future<void> getGame() {
    // TODO: implement getGame
    throw UnimplementedError();
  }

  @override
  Future<void> getGift() {
    // TODO: implement getGift
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>?> getLeaderBoard() async {
    try {
      final response = await supabaseClient
          .from('users')
          .select('*')
          .order('score', ascending: false)
          .limit(10)
          .execute();
      return (response.data as List<dynamic>)
          .map((data) => UserModel.fromJson(data))
          .toList();
    } catch (e) {
      print('Error fetching leaderboard: $e');
      return null;
    }
  }

  @override
  Future<void> startGame() {
    // TODO: implement startGame
    throw UnimplementedError();
  }

}
