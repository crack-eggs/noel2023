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
    EventInApp().gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.stopTap.name,
        payload: {});
  }

  void onUserGetGift() async {
    setState(ViewState.busy);
    final random = Random().nextInt(100) + 1;
    final jackpotRange =
        ((AppSettings().settings?.jackpot ?? 0) / 3).round() + 1;

    final currentHammers = UserService().currentUser?.hammers ?? 0;
    var giftRange = calculateGiftRange(currentHammers, jackpotRange);

    await handleGift(random, jackpotRange, giftRange);

    await usecase.fetch();
    setState(ViewState.idle);
  }

  double calculateGiftRange(int currentHammers, int jackpotRange) {
    if (currentHammers < 5) {
      return (100 - jackpotRange) / 2 + jackpotRange;
    }

    final factor = 2 + ((currentHammers - 5) / 10).round() / 1.5;
    return (100 - jackpotRange) / factor + jackpotRange;
  }

  Future<void> handleGift(
      int random, int jackpotRange, double giftRange) async {
    if (random < jackpotRange) {
      await handleJackpot();
    } else if (random < giftRange) {
      await handleGiftType();
    } else {
      await handleEmptyGift();
    }
  }

  Future<void> handleJackpot() async {
    final randomJackpot =
        Random().nextInt(AppSettings().settings?.jackpot ?? 0) + 1;

    EventInApp().gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.getGift.name,
        payload: {'giftType': GiftType.jackpot.name, });
    await Future.wait([
      gameUsecase.updateJackpot(
          quantity: (AppSettings().settings?.jackpot ?? 0) - randomJackpot),
      usecase.updateHammer(quantity: randomJackpot)
    ]);
    await Future.wait([
      AppSettings().fetch(),
      gameUsecase.updateGame(
          matchId: matchId, payload: {'giftType': GiftType.jackpot.name, 'jackpot': randomJackpot})
    ]);
  }

  Future<void> handleGiftType() async {
    final randomScore = Random().nextInt(100) + 1;

    EventInApp().gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.getGift.name,
        payload: {'giftType': GiftType.gift.name, 'gift': randomScore});

    await Future.wait([
      usecase.updateScore(randomScore),
      gameUsecase.updateGame(
          matchId: matchId,
          payload: {'giftType': GiftType.gift.name, 'gift': randomScore})
    ]);
  }

  Future<void> handleEmptyGift() async {
    EventInApp().gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.getGift.name,
        payload: {'giftType': GiftType.empty.name});
    await gameUsecase.updateJackpot();
    await Future.wait([
      AppSettings().fetch(),
      gameUsecase.updateGame(
          matchId: matchId, payload: {'giftType': GiftType.empty.name})
    ]);
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
