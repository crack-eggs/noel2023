import 'package:flutter/material.dart';
import '../shared/base_view.dart';

import '../../route.dart';
import '../provider/sign_in_google_provider.dart';

class SignInGoogleScreen extends StatefulWidget {

  const SignInGoogleScreen({Key? key, }) : super(key: key);

  @override
  _SignInGoogleScreenState createState() => _SignInGoogleScreenState();
}

class _SignInGoogleScreenState extends State<SignInGoogleScreen>
    with VMState<SignInGoogleProvider, SignInGoogleScreen> {
  Future<void> _handleSignIn() async {
    viewModel.onUserSignInGoogle(success: () {
      AppRouter.router.navigateTo(context, '/user-profile');
    });
  }

  @override
  Widget createWidget(BuildContext context, SignInGoogleProvider viewModel) {
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

  @override
  void onVMReady(SignInGoogleProvider viewModel, BuildContext context) {
    // TODO: implement onVMReady
  }
}
