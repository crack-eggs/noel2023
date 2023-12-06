import '../repositories/game_repository.dart';

class GameUsecase {
  final GameRepository gameRepository;

  GameUsecase(this.gameRepository);

  Future<void> createMatch({required String id}) async {
    return await gameRepository.createMatch(id);
  }

  Future<bool> checkGameValidation(String id) async {
    return await gameRepository.checkGameValidation(id);
  }

  Future<void> markGameAsDone({required String matchId})async {
    return await gameRepository.markGameAsDone(matchId);
  }
}
