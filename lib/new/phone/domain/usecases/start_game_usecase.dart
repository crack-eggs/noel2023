import '../repositories/game_repository.dart';

class StartGameUsecase {
  final GameRepository gameRepository;

  StartGameUsecase(this.gameRepository);

  Future<void> execute(String uuid) async {
    await gameRepository.startGame(uuid);
  }
}
