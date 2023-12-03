import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/game_repository.dart';
import '../../main.dart';
import '../../utils/cryto.dart';
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
    print('GameRepositoryImpl.getLeaderBoard');
    try {
      final response = await dio.get(
        '/user/leaderboard',
        queryParameters: {
          'code': encryptBlowfish(),
        },
      );
      return (response.data as List<dynamic>)
          .map((data) => UserModel.fromJson(data))
          .toList();
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Future<void> startGame() {
    // TODO: implement startGame
    throw UnimplementedError();
  }
}
