import 'package:noel/service/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/game_repository.dart';
import '../../main.dart';
import '../../utils/cryto.dart';
import '../models/user_model.dart';

class GameRepositoryImpl implements GameRepository {
  final SupabaseClient supabaseClient;

  GameRepositoryImpl(this.supabaseClient);

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
  Future<void> createMatch(String matchId) async {
    print('GameRepositoryImpl.createMatch');
    await dio.post(
      '/user/create-match',
      queryParameters: {
        'code': encryptBlowfish(),
      },
      data: {
        'id': matchId,
        if (UserService().currentUser != null)
          'email': UserService().currentUser!.email,
      },
    );
  }

  @override
  Future<bool> checkGameValidation(String id) async {
    try {
      final result =  await dio.get(
        '/user/match-validate',
        queryParameters: {
          'code': encryptBlowfish(),
          'match_id': id,
        },
      );
      return result.data;
    } catch (e) {
      print('error: ${e.toString()}');
      rethrow;
    }
  }
}
