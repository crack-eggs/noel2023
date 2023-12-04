import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:noel/constants.dart';
import 'package:noel/utils/toast.dart';
import '../../enums.dart';
import '../../service/user_service.dart';
import '../shared/base_view.dart';

import '../../route.dart';
import '../provider/sign_in_google_provider.dart';
import '../shared/sigin_button.dart';

class SignInGoogleScreen extends StatefulWidget {
  const SignInGoogleScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);
  final String matchId;

  @override
  _SignInGoogleScreenState createState() => _SignInGoogleScreenState();
}

class _SignInGoogleScreenState extends State<SignInGoogleScreen>
    with VMState<SignInGoogleProvider, SignInGoogleScreen> {
  Future<void> _handleSignIn(GoogleSignInUserData? userData) async {
    await viewModel.onUserSignInGoogle(
        userData: userData,
        success: () {
          AppRouter.router.navigateTo(
              context, '/user-profile?match_id=${widget.matchId}',
              transition: TransitionType.fadeIn);
        });
  }

  @override
  Widget createWidget(BuildContext context, SignInGoogleProvider viewModel) {
    return consumer(
      builder: (BuildContext context, SignInGoogleProvider viewModel, _) =>
          viewModel.state == ViewState.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: UserService().currentUser != null
                      ? ButtonConfiguratorDemo(
                          onUserSignInSuccess:
                              (GoogleSignInUserData? userData) async {
                            await _handleSignIn(userData);
                          },
                        )
                      : const CircularProgressIndicator()),
    );
  }

  @override
  void onVMReady(SignInGoogleProvider viewModel, BuildContext context) {
    viewModel.init(widget.matchId, () {
      AppRouter.router.navigateTo(
          context, '/user-profile?match_id=${widget.matchId}',
          transition: TransitionType.fadeIn);
    }, () {
      AppToast.showError(
          "Game id not valid, please try again with another id!");
    });
  }
}
