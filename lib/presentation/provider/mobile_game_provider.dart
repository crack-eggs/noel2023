import 'dart:math';

import 'package:noel/constants.dart';
import 'package:noel/service/app_settings_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/game_model.dart';
import '../../domain/usecases/game_usecase.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../enums.dart';
import '../../service/event_in_app.dart';
import '../../service/navigator_service.dart';
import '../../service/user_service.dart';
import '../shared/base_view_model.dart';

class MobileGameProvider extends BaseViewModel {
  final SupabaseClient supabaseClient;
  final NavigationService na;
  final UserUsecase usecase;
  final GameUsecase gameUsecase;

  MobileGameProvider(this.supabaseClient, this.na, this.usecase,
      this.gameUsecase)
      : super(supabaseClient, na);

  int countTap = 0;

  StateGame stateGame = StateGame.start;

  late String matchId;

  void onUserStopTap() {
    print('MobileGameProvider.onUserStopTap');
    stateGame = StateGame.end;
    setState(ViewState.idle);
    EventInApp().gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.stopTap.name,
        payload: {});
  }

  void onUserGetGift() async {
    setState(ViewState.busy);
    final random = Random().nextInt(100) + 1;
    final jackpotPercent =
        ((AppSettings().settings?.jackpot ?? 0) / 2).round() + 1;
    final giftPercent = (100 - jackpotPercent) / 2 + jackpotPercent;
    if (random < jackpotPercent) {
      /// get jackpot
      EventInApp().gameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.getGift.name,
          payload: {'giftType': GiftType.jackpot.name});
    } else if (random < giftPercent) {
      /// get gift
      final randomScore = Random().nextInt(50) + 50;
      await usecase.updateScore(randomScore);

      EventInApp().gameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.getGift.name,
          payload: {'giftType': GiftType.gift.name, 'gift': randomScore});
    } else {
      /// get empty
      EventInApp().gameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.getGift.name,
          payload: {'giftType': GiftType.empty.name});
      await gameUsecase.updateJackpot();
      await AppSettings().fetch();
    }

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
      EventInApp().gameChannel.send(
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
    EventInApp().gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.startTap.name,
        payload: {});

    setState(ViewState.idle);
  }
}
