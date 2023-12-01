import 'package:flutter/material.dart';
import '../shared/base_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../enums.dart';

class WebGameProvider extends BaseViewModel {
  late AnimationController _controller;

  WebGameProvider(super.supabase, super.navigatorService);

  setController(AnimationController controller) {
    _controller = controller;
  }

  void _watch() {
    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.startTap.name,
        ), (payload, [ref]) {
      print('start tap');
      _controller.repeat();
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.stopTap.name,
        ), (payload, [ref]) {
      print('stop tap');
      _controller.stop();
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.getGift.name,
        ), (payload, [ref]) {
      print('get gift');
      print('Chuc mung ban nhan duoc qua: ${payload['data']['gift']}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
