// lib/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:noel/new/phone/data/repositories/leaderboard_repository_impl.dart';
import 'package:noel/new/phone/domain/repositories/leaderboard_repository.dart';
import 'package:noel/new/phone/presentation/pages/web_game_play_screen.dart';
import 'package:noel/new/phone/presentation/provider/leaderboard_provider.dart';
import 'package:noel/new/phone/presentation/provider/web_game_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart';
import '../data/repositories/game_repository.dart';
import '../data/repositories/user_repository.dart';
import '../domain/repositories/game_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../presentation/provider/game_provider.dart';
import '../presentation/provider/mobile_game_provider.dart';
import '../presentation/provider/sign_in_google_provider.dart';
import '../presentation/provider/user_provider.dart';
import '../service/realtime_service.dart';

final GetIt sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => RealtimeService(
        supabaseClient: supabase,
        config: const RealtimeChannelConfig(self: true, ack: true),
      ));

  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(supabase));
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(supabase));
  sl.registerLazySingleton<LeaderboardRepository>(
      () => LeaderboardRepositoryImpl(supabase));

  // Providers
  sl.registerLazySingleton(() => UserProvider(supabase));
  sl.registerLazySingleton(() => GameProvider());
  sl.registerLazySingleton(() => LeaderboardProvider(
      leaderboardRepository: sl.get<LeaderboardRepository>()));
  sl.registerLazySingleton(() => SignInGoogleProvider(supabase));
  sl.registerLazySingleton(() => MobileGameProvider(supabase));
  sl.registerLazySingleton(() => WebGameProvider());
}
