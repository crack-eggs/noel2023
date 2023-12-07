import '../data/models/settings.dart';
import '../di/injection.dart';
import '../domain/usecases/game_usecase.dart';

class AppSettings {
  // create singleton
  AppSettings._privateConstructor();

  static final AppSettings _instance = AppSettings._privateConstructor();

  factory AppSettings() {
    return _instance;
  }

  final GameUsecase _gameUsecase = sl<GameUsecase>();

  Settings? settings;

  Future<void> fetch() async {
    settings = await _gameUsecase.getSettings();
  }
}
