import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart';
import '../data/repositories/game_repository.dart';
import '../data/repositories/user_repository.dart';
import '../domain/repositories/game_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/usecases/game_usecase.dart';
import '../domain/usecases/leader_board_usecase.dart';
import '../domain/usecases/user_usecase.dart';
import '../presentation/provider/game_provider.dart';
import '../presentation/provider/web_home_provider.dart';
import '../presentation/provider/mobile_game_provider.dart';
import '../presentation/provider/sign_in_google_provider.dart';
import '../presentation/provider/user_provider.dart';
import '../presentation/provider/web_game_provider.dart';
import '../service/app_settings_service.dart';
import '../service/navigator_service.dart';
import '../service/realtime_service.dart';

final GetIt sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => RealtimeService(
        supabaseClient: supabase,
        config: const RealtimeChannelConfig(self: true, ack: true),
      ));
  sl.registerLazySingleton(AppService.new);

  sl.registerLazySingleton(
      () => NavigationService(sl<AppService>().topNavigationKey));

  // sl.registerLazySingleton(() => AppSettings(sl()));
  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(supabase));
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(supabase));

  // Providers
  sl.registerFactory(() => UserProvider(supabase, sl(), sl(), sl()));
  sl.registerFactory(() => GameProvider());
  sl.registerFactory(() => WebHomeProvider(supabase, sl(), sl(), sl()));
  sl.registerFactory(() => SignInGoogleProvider(supabase, sl(), sl(), sl()));
  sl.registerFactory(() => MobileGameProvider(
        supabase,
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => WebGameProvider(
        supabase,
        sl(),
        sl(),
      ));

  // usecase
  sl.registerFactory(() => LeaderBoardUsecase(sl()));
  sl.registerFactory(() => UserUsecase(sl()));
  sl.registerFactory(() => GameUsecase(sl()));
}
