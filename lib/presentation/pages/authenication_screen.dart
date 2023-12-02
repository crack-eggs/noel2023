import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:noel/constants.dart';
import '../shared/base_view.dart';

import '../../route.dart';
import '../provider/sign_in_google_provider.dart';
import '../shared/sigin_button.dart';

class SignInGoogleScreen extends StatefulWidget {
  const SignInGoogleScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignInGoogleScreenState createState() => _SignInGoogleScreenState();
}

class _SignInGoogleScreenState extends State<SignInGoogleScreen>
    with VMState<SignInGoogleProvider, SignInGoogleScreen> {
  Future<void> _handleSignIn(GoogleSignInUserData? userData) async {
    await viewModel.onUserSignInGoogle(
        userData: userData,
        success: () {
          AppRouter.router.navigateTo(context, '/user-profile');
        });
  }

  @override
  Widget createWidget(BuildContext context, SignInGoogleProvider viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Login'),
      ),
      body: Center(child: ButtonConfiguratorDemo(
        onUserSignInSuccess: (GoogleSignInUserData? userData) async {
          await _handleSignIn(userData);
        },
      )),
    );
  }

  @override
  void onVMReady(SignInGoogleProvider viewModel, BuildContext context) {
  }
}
