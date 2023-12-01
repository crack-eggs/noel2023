// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:noel/connection/egg_connection.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../enums.dart';
// import '../main.dart';
//
// class QRCodeScreen extends StatefulWidget {
//   const QRCodeScreen({super.key});
//
//   @override
//   State<QRCodeScreen> createState() => _QRCodeScreenState();
// }
//
// class _QRCodeScreenState extends State<QRCodeScreen> {
//   StreamSubscription? stream;
//
//   @override
//   void initState() {
//     EggConnection().listenStart(
//       callback: (payload) {
//         Navigator.of(context).pushReplacementNamed('/match');
//       },
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: QrImageView(
//         data: 'http://localhost:10000/#/signin?matchId=1234567890',
//         version: QrVersions.auto,
//         size: 200.0,
//       ),
//     ));
//   }
//
//   @override
//   void dispose() {
//     stream?.cancel();
//     super.dispose();
//   }
// }
