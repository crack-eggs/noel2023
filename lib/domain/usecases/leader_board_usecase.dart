
import '../../data/models/user_model.dart';
import '../repositories/game_repository.dart';

class LeaderBoardUsecase{
  final GameRepository gameRepository;

  LeaderBoardUsecase(this.gameRepository);

  Future<List<UserModel>?> call() async {
    return await gameRepository.getLeaderBoard();
  }
}
