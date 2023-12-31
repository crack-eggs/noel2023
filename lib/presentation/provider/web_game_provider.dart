import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noel/domain/usecases/game_usecase.dart';
import 'package:noel/service/event_in_app.dart';
import '../../service/app_settings_service.dart';
import '../shared/base_view_model.dart';
import '../../enums.dart';

class WebGameProvider extends BaseViewModel {
  late AnimationController _controller;

  final GameUsecase gameUsecase;

  StreamSubscription? _sub;

  EventType lastEventType = EventType.start;

  int countdownToClose = 30;

  GiftType? lastGiftType;
  int score = 0;

  Function()? pop;

  Timer? _timer;

  WebGameProvider(super.supabase, super.navigatorService, this.gameUsecase);

  setController(AnimationController controller) {
    _controller = controller;
  }

  late String matchId;

  init(String matchId) {
    this.matchId = matchId;
    _watch();
  }

  _triggerCountDown() {
    countdownToClose = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownToClose == 0) {
        _timer?.cancel();
        onUserBackToHome();
      } else {
        countdownToClose--;
        setState(ViewState.idle);
      }
    });
  }

  void _watch() {
    _sub ??= EventInApp().controller.stream.listen((event) {
      if (event.eventType == EventType.stopTap) {
        setState(ViewState.idle);
        return;
      }
      lastEventType = event.eventType;

      if (event.eventType == EventType.restartGame) {
        _controller.repeat(reverse: true);
        _timer?.cancel();
        setState(ViewState.idle);
      }

      if (event.eventType == EventType.startTap) {
        _controller.repeat(reverse: true);
        _timer?.cancel();
        setState(ViewState.idle);
      }

      if (event.eventType == EventType.getGift) {
        _controller.stop();

        _triggerCountDown();

        final giftType = event.payload['payload']['giftType'];
        if (giftType == GiftType.jackpot.name) {
          lastGiftType = GiftType.jackpot;
          setState(ViewState.idle);

          AppSettings().fetch();
          setState(ViewState.idle);
        } else if (giftType == GiftType.empty.name) {
          lastGiftType = GiftType.empty;
          setState(ViewState.idle);

          AppSettings().fetch();
        } else if (giftType == GiftType.gift.name) {
          lastGiftType = GiftType.gift;
          score = event.payload['payload']['gift'];
          setState(ViewState.idle);
        }
      }
      setState(ViewState.idle);
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
    if (pop != null) pop!();

    gameUsecase.markGameAsDone(matchId: matchId);
  }
}
