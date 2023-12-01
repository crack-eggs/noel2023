import 'package:noel/new/phone/domain/repositories/game_repository.dart';

import '../../data/models/user_model.dart';

class LeaderBoardUsecase{
  final GameRepository gameRepository;

  LeaderBoardUsecase(this.gameRepository);

  Future<List<UserModel>?> call() async {
    return await gameRepository.getLeaderBoard();
  }
}
