import 'dart:math';

import 'package:noel/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/game_model.dart';
import '../../domain/usecases/game_usecase.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../enums.dart';
import '../../service/navigator_service.dart';
import '../../service/user_service.dart';
import '../shared/base_view_model.dart';

class MobileGameProvider extends BaseViewModel {
  final SupabaseClient supabaseClient;
  final NavigationService na;
  final UserUsecase usecase;
  final GameUsecase gameUsecase;

  MobileGameProvider(
      this.supabaseClient, this.na, this.usecase, this.gameUsecase)
      : super(supabaseClient, na);

  int countTap = 0;

  StateGame stateGame = StateGame.start;

  late String matchId;

  void onUserStopTap() {
    print('MobileGameProvider.onUserStopTap');
    stateGame = StateGame.end;
    setState(ViewState.idle);
    stopTapChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.stopTap.name,
        payload: {});
  }

  void onUserGetGift() async {
    print('MobileGameProvider.onUserGetGift');
    setState(ViewState.busy);
    final random = Random().nextInt(100);
    getGiftChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.getGift.name,
        payload: {'type': 1, 'gift': random});

    await usecase.updateScore(random);
    await usecase.fetch();
    setState(ViewState.idle);
  }

  void onUserTap() {
    onUserStopTap();
    onUserGetGift();
  }

  void onUserContinue({required Function onFailure}) async {
    setState(ViewState.busy);

    if (UserService().currentUser!.hammers > 0) {
      final validate = await gameUsecase.checkGameValidation(matchId);
      if (validate == false) {
        onFailure();
        setState(ViewState.idle);
        return;
      }
      await usecase.reduceHammer();
      await usecase.fetch();

      stateGame = StateGame.start;
      restartGameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.restartGame.name,
          payload: {});
      setState(ViewState.idle);
    }
  }

  void init(String matchId) {
    this.matchId = matchId;
    setState(ViewState.busy);

    stateGame = StateGame.start;
    startTapChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.startTap.name,
        payload: {});

    setState(ViewState.idle);
  }
}
