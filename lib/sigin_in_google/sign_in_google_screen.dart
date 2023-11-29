// import 'package:flutter/material.dart';
// import 'package:noel/connection/player_connection.dart';
//
//
// class SignInGoogleScreen extends StatefulWidget {
//   final String matchId;
//
//   const SignInGoogleScreen({super.key, required this.matchId});
//
//   @override
//   State<SignInGoogleScreen> createState() => _SignInGoogleScreenState();
// }
//
// class _SignInGoogleScreenState extends State<SignInGoogleScreen> {
//   Future<void> _handleSignIn() async {
//       print('_SignInGoogleScreenState._handleSignIn');
//       print('widget.matchId: ${widget.matchId}');
//     // await PlayerConnection().onUserLogin();
//       // await PlayerConnection().onCreateNewUser();
//       await PlayerConnection().onUserStartPlayGame(matchId: widget.matchId);
//
//       Navigator.of(context).pushReplacementNamed('/cracker');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             _handleSignIn();
//           },
//           child: const Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }
