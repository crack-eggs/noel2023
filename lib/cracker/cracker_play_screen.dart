// import 'package:flutter/material.dart';
// import 'package:noel/connection/player_connection.dart';
//
// class CrackerPlayScreen extends StatefulWidget {
//   const CrackerPlayScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CrackerPlayScreen> createState() => _CrackerPlayScreenState();
// }
//
// class _CrackerPlayScreenState extends State<CrackerPlayScreen> {
//   int count = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             if (count == 0) {
//               PlayerConnection().onUserStartCrack();
//             }
//
//             if (count == 10) {
//               PlayerConnection().onUserStopCrack();
//             }
//             count++;
//           },
//           child: const Text('Tap Tap'),
//         ),
//       ),
//     );
//   }
// }
