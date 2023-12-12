import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mobile/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: consumer(
            builder:
                (BuildContext context, SignInGoogleProvider viewModel, _) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        _buildBanner(),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              'assets/mobile/snow.png',
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                            viewModel.state == ViewState.busy
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: UserService().currentUser == null
                                        ? ButtonConfiguratorDemo(
                                            onUserSignInSuccess:
                                                (GoogleSignInUserData?
                                                    userData) async {
                                              await _handleSignIn(userData);
                                            },
                                          )
                                        : const CircularProgressIndicator()),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Image.asset(
                          'assets/mobile/bottom.png',
                          fit: BoxFit.fill,
                        ),
                      ],
                    )),
      )),
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

  Widget _buildBanner() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          'assets/mobile/banner.png',
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            width: 220,
            child: Text('LOGIN',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 24),
                )),
          ),
        ),
      ],
    );
  }
}
