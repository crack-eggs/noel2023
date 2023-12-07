import '../data/models/settings.dart';
import '../domain/usecases/game_usecase.dart';

class AppSettings {
  final GameUsecase gameUsecase;

  Settings? settings;

  AppSettings(this.gameUsecase);

  void fetch() async {
    settings = await gameUsecase.getSettings();
  }
}
