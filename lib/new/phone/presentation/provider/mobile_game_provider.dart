import 'package:flutter/material.dart';
import 'package:noel/new/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../enums.dart';

class MobileGameProvider extends ChangeNotifier {
  final SupabaseClient supabaseClient;

  MobileGameProvider(this.supabaseClient);

  void onUserStartTap() {
    gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.startTap.name,
        payload: {});
  }

  void onUserStopTap() {
    print('MobileGameProvider.onUserStopTap');
    gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.stopTap.name,
        payload: {});
  }
}
