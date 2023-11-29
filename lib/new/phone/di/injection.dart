// lib/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:noel/main.dart';

import '../data/repositories/game_repository.dart';
import '../data/repositories/user_repository.dart';
import '../domain/repositories/game_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../presentation/provider/game_provider.dart';
import '../presentation/provider/user_provider.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(supabase));
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(supabase));

  // Providers
  sl.registerLazySingleton(() => UserProvider());
  sl.registerLazySingleton(() => GameProvider());
}
