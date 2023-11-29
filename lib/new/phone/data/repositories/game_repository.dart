import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/game.dart';
import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final SupabaseClient supabaseClient;

  GameRepositoryImpl(this.supabaseClient);

  @override
  Future<void> startGame(String uuid) async {}

  @override
  Future<Game?> getGame(String uuid) async {}
}
