import 'dart:math';

import 'package:noel/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/game_model.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../enums.dart';
import '../../service/navigator_service.dart';
import '../../service/user_service.dart';
import '../shared/base_view_model.dart';

class MobileGameProvider extends BaseViewModel {
  final SupabaseClient supabaseClient;
  final NavigationService na;
  final UserUsecase usecase;

  MobileGameProvider(this.supabaseClient, this.na, this.usecase)
      : super(supabaseClient, na);

  int countTap = 0;

  StateGame stateGame = StateGame.start;

  void onUserStartTap() async {
    if (UserService().currentUser!.hammers > 0) {
      setState(ViewState.busy);

      countTap = 0;
      await supabaseClient
          .from('users')
          .update({'hammers': UserService().currentUser!.hammers - 1})
          .eq('email', UserService().currentUser?.email)
          .execute();
      await usecase.fetch();
      stateGame = StateGame.start;
      gameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.startTap.name,
          payload: {});

      setState(ViewState.idle);
    }
  }

  void onUserStopTap() {
    print('MobileGameProvider.onUserStopTap');
    stateGame = StateGame.end;
    setState(ViewState.idle);
    gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.stopTap.name,
        payload: {});
  }

  void onUserGetGift() async {
    print('MobileGameProvider.onUserGetGift');
    setState(ViewState.busy);
    final random = Random().nextInt(100);
    gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.getGift.name,
        payload: {'type': 1, 'gift': random});

    await Future.wait([
      usecase.updateScore(random),
    ]);

    // GameModel gameModel = GameModel(
    //     score: random,
    //     email: UserService().currentUser?.email,
    //     hammersRemain: UserService().currentUser!.hammers);
    // await Future.wait([
    //   supabaseClient.from('games').insert(gameModel.toJson()).execute(),
    //   supabaseClient
    //       .from('users')
    //       .update({
    //         'score': UserService().currentUser!.score + random,
    //       })
    //       .eq('email', UserService().currentUser?.email)
    //       .execute()
    // ]);
    // await usecase.fetch();
    // setState(ViewState.idle);
  }

  void onUserTap() {
    onUserStopTap();

    onUserGetGift();
    // if (countTap == 0) {
    //   onUserStartTap();
    // }
    //
    // if (countTap == 1) {
    //   onUserStopTap();
    //
    //   onUserGetGift();
    //   countTap = 0;
    // }
    // countTap++;
  }

  void onUserContinue() async {
    setState(ViewState.busy);

    if (UserService().currentUser!.hammers > 0) {
      countTap = 0;
      await supabaseClient
          .from('users')
          .update({'hammers': UserService().currentUser!.hammers - 1})
          .eq('email', UserService().currentUser?.email)
          .execute();
      await usecase.fetch();

      stateGame = StateGame.start;
      gameChannel.send(
          type: RealtimeListenTypes.broadcast,
          event: EventType.restartGame.name,
          payload: {});
      setState(ViewState.idle);
    }
  }
}
