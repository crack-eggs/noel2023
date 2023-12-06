import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noel/domain/usecases/game_usecase.dart';
import 'package:noel/service/event_in_app.dart';
import 'package:noel/utils/toast.dart';
import '../shared/base_view_model.dart';
import '../../enums.dart';

class WebGameProvider extends BaseViewModel {
  late AnimationController _controller;

  final GameUsecase gameUsecase;

  StreamSubscription? _sub;

  EventType lastEventType = EventType.start;

  int countdownToClose = 15;

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
      lastEventType = event.eventType;
      print('lastEventType: $lastEventType');
      if (event.eventType == EventType.restartGame) {
        _controller.repeat();
        _timer?.cancel();
      }

      if (event.eventType == EventType.startTap) {
        _controller.repeat();
      }

      if (event.eventType == EventType.stopTap) {
        _controller.stop();
      }

      if (event.eventType == EventType.getGift) {
        _triggerCountDown();
        AppToast.show(
            'Chuc mung ban nhan duoc qua: ${event.payload['payload']['gift']}');
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
