import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums.dart';
import '../main.dart';

class PlayerConnection {
  static final PlayerConnection _connection = PlayerConnection._internal();

  factory PlayerConnection() => _connection;

  GoogleSignInAccount? user;

  PlayerConnection._internal() {
    print('GameConnection created');
  }

  Future<void> onUserLogin() async {
    user = await googleSignIn.signIn();
  }

  Future<void> onCreateNewUser() async {
    try {
      await supabase
          .from('users')
          .select('*')
          .eq('email', user?.email)
          .execute();
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> onUserPlayGame() async {
    print('PlayerConnection.onUserPlayGame');
    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
        ), (payload, [ref]) {
      print('EventType.start.name');
      print('payload: $payload');
    });

    gameChannel.send(
        type: RealtimeListenTypes.broadcast,
        event: EventType.start.name,
        payload: {'email': user!.email});
  }
}
