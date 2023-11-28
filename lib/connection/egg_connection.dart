import 'package:noel/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums.dart';

class EggConnection {
  static final EggConnection _connection = EggConnection._internal();

  factory EggConnection() => _connection;

  EggConnection._internal() {
    print('EggConnection._internal');
    supabase.channel('game').on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.start.name,
        ), (payload, [ref]) {
      print('EventType.start.name');
      print('payload: $payload');
    });
  }
}
