import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:noel/new/phone/presentation/pages/authenication_screen.dart';
import 'package:noel/new/phone/presentation/pages/home_page.dart';
import 'package:noel/new/phone/presentation/pages/mobile_game_play_screen.dart';
import 'package:noel/new/phone/presentation/pages/user_profile_screen.dart';
import 'package:noel/new/phone/presentation/pages/web_game_play_screen.dart';
import 'package:noel/new/phone/service/user_service.dart';

class AppRouter {
  static FluroRouter router = FluroRouter();

  static void setupRouter() {
    // Define your routes here
    router.define(
      '/',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          // Return the widget you want to display for this route
          return HomePage();
        },
      ),
    );

    router.define(
      '/web-game-play',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          // Return the widget you want to display for this route
          return const WebGamePlayScreen();
        },
      ),
    );

    router.define(
      '/user-profile',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          // Return the widget you want to display for this route
          return const UserProfileScreen();
        },
      ),
    );

    router.define(
      '/mobile-game-play',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          // Return the widget you want to display for this route
          return const MobileGamePlayScreen();
        },
      ),
    );
    router.define(
      '/login',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
            return SignInGoogleScreen(
              matchId: params['match_id'][0],
            );

          // Return the widget you want to display for this route
        },
      ),
    );

    // Add more routes as needed
  }
}
