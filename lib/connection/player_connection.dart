// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../enums.dart';
// import '../main.dart';
//
// class PlayerConnection {
//   static final PlayerConnection _connection = PlayerConnection._internal();
//
//   factory PlayerConnection() => _connection;
//
//   GoogleSignInAccount? user;
//
//   PlayerConnection._internal();
//
//   Future<void> onUserLogin() async {
//     user = await googleSignIn.signIn();
//   }
//
//   Future<void> onCreateNewUser() async {
//     try {
//       await supabase
//           .from('users')
//           .select('*')
//           .eq('email', user?.email)
//           .execute();
//     } catch (e) {
//       print('error: $e');
//     }
//   }
//
//   Future<void> onUserStartPlayGame({required String matchId}) async {
//     gameChannel.send(
//         type: RealtimeListenTypes.broadcast,
//         event: EventType.start.name,
//         payload: {'email': 'ducduy.dev@gmail.com', 'matchId': matchId});
//   }
//
//   Future<void> onUserStartCrack() async {
//     gameChannel.send(
//         type: RealtimeListenTypes.broadcast,
//         event: EventType.startCrack.name,
//         payload: {
//           'email': 'ducduy.dev@gmail.com',
//         });
//   }
//
//   Future<void> onUserStopCrack() async {
//     gameChannel.send(
//         type: RealtimeListenTypes.broadcast,
//         event: EventType.stopCrack.name,
//         payload: {
//           'email': 'ducduy.dev@gmail.com',
//         });
//   }
// }
