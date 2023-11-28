import 'package:fluro/fluro.dart';
import 'package:noel/cracker/cracker_play_screen.dart';
import 'package:noel/egg/egg_screen.dart';
import 'package:noel/qrCode/qr_code_component.dart';

import '../main.dart';
import '../sigin_in_google/sign_in_google_screen.dart';

class AppRouter {
  static late FluroRouter router;

  static void configureRoutes() {
    print('AppRouter.configureRoutes');
    router.define(
      '/',
      handler: Handler(handlerFunc: (context, parameters) {
        print('parameters; $parameters');
        return const MyHomePage(
          title: '',
        );
      }),
    );
    router.define(
      '/signin',
      handler: Handler(handlerFunc: (context, parameters) {
        print('parameters; $parameters');
        return SignInGoogleScreen(matchId: parameters['matchId']!.first);
      }),
    );

    router.define(
      '/qrCode',
      handler: Handler(handlerFunc: (context, parameters) {
        return const QRCodeScreen();
      }),
    );
    router.define(
      '/match',
      handler: Handler(handlerFunc: (context, parameters) {
        return const EggScreen();
      }),
    );
    router.define(
      '/cracker',
      handler: Handler(handlerFunc: (context, parameters) {
        return const CrackerPlayScreen();
      }),
    );
  }
}
