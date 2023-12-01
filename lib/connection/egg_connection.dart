// import 'package:flutter/material.dart';
// import 'package:noel/main.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../enums.dart';
//
// class EggConnection {
//   static final EggConnection _connection = EggConnection._internal();
//
//   factory EggConnection() => _connection;
//
//   EggConnection._internal() {
//     print('EggConnection._internal');
//   }
//
//   void listenStart({required Function(Map<String, dynamic>) callback}) {
//     gameChannel.on(
//         RealtimeListenTypes.broadcast,
//         ChannelFilter(
//           event: EventType.start.name,
//         ), (payload, [ref]) {
//       callback(payload);
//     });
//   }
//   void listenStartCrack({required Function(Map<String, dynamic>) callback}) {
//     gameChannel.on(
//         RealtimeListenTypes.broadcast,
//         ChannelFilter(
//           event: EventType.startCrack.name,
//         ), (payload, [ref]) {
//       callback(payload);
//     });
//   }
//   void listenStopCrack({required Function(Map<String, dynamic>) callback}) {
//     gameChannel.on(
//         RealtimeListenTypes.broadcast,
//         ChannelFilter(
//           event: EventType.stopCrack.name,
//         ), (payload, [ref]) {
//       callback(payload);
//     });
//   }
// }
