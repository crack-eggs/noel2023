import 'package:flutter/material.dart';
import 'package:noel/connection/player_connection.dart';


class SignInGoogleScreen extends StatefulWidget {
  final String matchId;

  const SignInGoogleScreen({super.key, required this.matchId});

  @override
  State<SignInGoogleScreen> createState() => _SignInGoogleScreenState();
}

class _SignInGoogleScreenState extends State<SignInGoogleScreen> {
  Future<void> _handleSignIn() async {
    try {
      // await PlayerConnection().onUserLogin();
      await PlayerConnection().onCreateNewUser();
      await PlayerConnection().onUserPlayGame();

      Navigator.of(context).pushReplacementNamed('/cracker');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            _handleSignIn();
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
