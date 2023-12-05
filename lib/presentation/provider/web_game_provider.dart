import 'package:flutter/material.dart';
import 'package:noel/utils/toast.dart';
import '../shared/base_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../enums.dart';

class WebGameProvider extends BaseViewModel {
  late AnimationController _controller;

  RealtimeChannel? _startTapSub;
  RealtimeChannel? _stopTapSub;
  RealtimeChannel? _getGiftSub;
  RealtimeChannel? _reStartSub;

  WebGameProvider(super.supabase, super.navigatorService);

  setController(AnimationController controller) {
    _controller = controller;
  }

  init() {
    _watch();
  }

  void _watch() {
    _startTapSub ??= gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.startTap.name,
        ), (payload, [ref]) {
      print('start tap');
      _controller.repeat();
    });

    _stopTapSub ??= gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.stopTap.name,
        ), (payload, [ref]) {
      print('stop tap');
      _controller.stop();
    });

    _getGiftSub ??= gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.getGift.name,
        ), (payload, [ref]) {
      print('payload: $payload');
      AppToast.show(
          'Chuc mung ban nhan duoc qua: ${payload['payload']['gift']}');
    });

    _reStartSub ??= gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.restartGame.name,
        ), (payload, [ref]) {
      _controller.repeat();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
