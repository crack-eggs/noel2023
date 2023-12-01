// import 'package:flutter/material.dart';
//
// import '../connection/egg_connection.dart';
//
// class EggScreen extends StatefulWidget {
//   const EggScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EggScreen> createState() => _EggScreenState();
// }
//
// class _EggScreenState extends State<EggScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 100),
//     );
//     EggConnection().listenStartCrack(
//       callback: (_) {
//         _controller.repeat();
//       },
//     );
//     EggConnection().listenStopCrack(
//       callback: (_) {
//         _controller.stop(canceled: true);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RotationTransition(
//       turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
//       child: const Icon(Icons.egg_outlined, size: 300),
//     );
//   }
// }
