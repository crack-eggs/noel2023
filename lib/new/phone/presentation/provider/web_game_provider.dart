import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../enums.dart';

class WebGameProvider extends ChangeNotifier {
  WebGameProvider() {
    _watch();
  }

  late AnimationController _controller;

  setController(AnimationController controller) {
    _controller = controller;
  }

  void _watch() {
    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.startTap.name,
        ), (payload, [ref]) {
      print('WebGameProvider._watch');
      _controller.repeat();
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.stopTap.name,
        ), (payload, [ref]) {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
