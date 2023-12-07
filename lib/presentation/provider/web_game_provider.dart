import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noel/domain/usecases/game_usecase.dart';
import 'package:noel/service/event_in_app.dart';
import 'package:noel/utils/toast.dart';
import '../../constants.dart';
import '../../service/app_settings_service.dart';
import '../shared/base_view_model.dart';
import '../../enums.dart';

class WebGameProvider extends BaseViewModel {
  late AnimationController _controller;

  final GameUsecase gameUsecase;

  StreamSubscription? _sub;

  EventType lastEventType = EventType.start;

  int countdownToClose = 15;

  GiftType? lastGiftType;
  int score = 0;

  Function()? pop;

  Timer? _timer;
  final AppSettings appSettings;

  WebGameProvider(super.supabase, super.navigatorService, this.gameUsecase,
      this.appSettings);

  setController(AnimationController controller) {
    _controller = controller;
  }

  late String matchId;

  init(String matchId) {
    this.matchId = matchId;
    _watch();
  }

  _triggerCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('countdownToClose: $countdownToClose');
      if (countdownToClose == 0) {
        _timer?.cancel();
        onUserBackToHome();
        if (pop != null) pop!();
      } else {
        countdownToClose--;
        setState(ViewState.idle);
      }
    });
  }

  void _watch() {
    _sub ??= EventInApp().controller.stream.listen((event) {
      if (event.eventType == EventType.stopTap) {
        return;
      }
      lastEventType = event.eventType;
      print('lastEventType: $lastEventType');
      if (event.eventType == EventType.restartGame) {
        _controller.repeat(reverse: true);
        _timer?.cancel();
      }

      if (event.eventType == EventType.startTap) {
        _controller.repeat(reverse: true);
      }

      if (event.eventType == EventType.stopTap) {
        _controller.stop();
      }

      if (event.eventType == EventType.getGift) {
        _controller.stop();

        // _triggerCountDown();

        final giftType = event.payload['payload']['giftType'];
        if (giftType == GiftType.jackpot.name) {
          lastGiftType = GiftType.jackpot;
          setState(ViewState.idle);

          appSettings.fetch();
          AppToast.show('Chuc mung ban nhan duoc jackpot');
          setState(ViewState.idle);
        } else if (giftType == GiftType.empty.name) {
          lastGiftType = GiftType.empty;
          setState(ViewState.idle);

          appSettings.fetch();
          AppToast.show(wishLists[Random().nextInt(wishLists.length - 1)]);
        } else if (giftType == GiftType.gift.name) {
          lastGiftType = GiftType.gift;
          score = event.payload['payload']['gift'];
          setState(ViewState.idle);

          AppToast.show(
              'Chuc mung ban nhan duoc qua: ${event.payload['payload']['payload']['gift']}');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sub?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  void onUserBackToHome() {
    gameUsecase.markGameAsDone(matchId: matchId);
  }
}
