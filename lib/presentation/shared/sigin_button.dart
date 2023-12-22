import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:noel/presentation/shared/render_web_button_config.dart';

import '../../constants.dart';

/// The home widget of this app.
class ButtonConfiguratorDemo extends StatefulWidget {
  /// A const constructor for the Widget.
  const ButtonConfiguratorDemo({super.key, required this.onUserSignInSuccess});

  final Function(GoogleSignInUserData) onUserSignInSuccess;

  @override
  State createState() => _ButtonConfiguratorState();
}

class _ButtonConfiguratorState extends State<ButtonConfiguratorDemo> {
  GoogleSignInUserData? _userData; // sign-in information?

  @override
  void initState() {
    super.initState();

    googleSignIn.userDataEvents?.listen((GoogleSignInUserData? userData) {
      if (userData != null) {
        widget.onUserSignInSuccess(userData);
      }
    });
  }

  Widget _buildBody() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("hi"),
              googleSignIn.renderButton(
                  configuration: GSIButtonConfiguration()),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
