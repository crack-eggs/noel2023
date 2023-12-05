import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noel/service/event_in_app.dart';
import 'package:noel/utils/toast.dart';
import '../shared/base_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../enums.dart';

class WebGameProvider extends BaseViewModel {
  late AnimationController _controller;

  StreamSubscription? _sub;

  WebGameProvider(super.supabase, super.navigatorService);

  setController(AnimationController controller) {
    _controller = controller;
  }

  init() {
    _watch();
  }

  void _watch() {
    _sub ??= EventInApp().controller.stream.listen((event) {
      print('event: $event');
      if (event.eventType == EventType.restartGame) {
        _controller.repeat();
      }

      if (event.eventType == EventType.startTap) {
        _controller.repeat();
      }

      if (event.eventType == EventType.stopTap) {
        _controller.stop();
      }

      if (event.eventType == EventType.getGift) {
        AppToast.show(
            'Chuc mung ban nhan duoc qua: ${event.payload['payload']['gift']}');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sub?.cancel();
    super.dispose();
  }
}
