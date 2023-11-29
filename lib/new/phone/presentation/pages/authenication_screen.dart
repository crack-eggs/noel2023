import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../route.dart';
import '../provider/sign_in_google_provider.dart';

class SignInGoogleScreen extends StatefulWidget {
  final String matchId;

  const SignInGoogleScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  _SignInGoogleScreenState createState() => _SignInGoogleScreenState();
}

class _SignInGoogleScreenState extends State<SignInGoogleScreen> {
  Future<void> _handleSignIn() async {
    Provider.of<SignInGoogleProvider>(context, listen: false)
        .onUserSignInGoogle(success: () {
      AppRouter.router.navigateTo(context, '/user-profile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _handleSignIn();
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
