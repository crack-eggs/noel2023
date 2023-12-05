import 'package:noel/domain/usecases/game_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../service/user_service.dart';
import '../shared/base_view_model.dart';

import '../../enums.dart';
import '../../route.dart';

class UserProvider extends BaseViewModel {
  UserProvider(super.supabase, super.navigatorService, this.userUsecase,
      this.gameUsecase);

  final UserUsecase userUsecase;
  final GameUsecase gameUsecase;

  updateUser() async {
    setState(ViewState.busy);
    print('UserProvider.updateUser');
    await userUsecase.fetch();
    setState(ViewState.idle);
  }

  void onUserTopUp(int number) async {
    print('UserProvider.onUserTopUp');
    setState(ViewState.busy);
    await userUsecase.topup(number);
    await userUsecase.fetch();

    setState(ViewState.idle);
  }

  void onUserStartGame(String matchId, {required onFailure}) async {
    setState(ViewState.busy);

    final validate = await gameUsecase.checkGameValidation(matchId);

    if (validate == false) {
      setState(ViewState.idle);
      onFailure();
    }
    if (UserService().currentUser!.hammers > 0) {
      await userUsecase.reduceHammer();
      await Future.wait([
        userUsecase.fetch(),
        gameChannel.send(
            type: RealtimeListenTypes.broadcast,
            event: EventType.start.name,
            payload: {})
      ]);

      AppRouter.router.navigateTo(
          navigatorService.context!, '/mobile-game-play?match_id=$matchId');
    }
    setState(ViewState.idle);
  }
}
