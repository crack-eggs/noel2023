import 'package:noel/domain/usecases/game_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../service/event_in_app.dart';
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
    print('UserProvider.updateUser');
    if (UserService().currentUser != null) {
      setState(ViewState.busy);
      await userUsecase.fetch();
      setState(ViewState.idle);
    }
  }

  void onUserTopUp(int number) async {
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
      return;
    }
    if (UserService().currentUser!.hammers > 0) {
      EventInApp().gameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.start.name,
          payload: {});

      AppRouter.router.navigateTo(
          navigatorService.context!, '/mobile-game-play?match_id=$matchId');
    }
    setState(ViewState.idle);
  }
}
