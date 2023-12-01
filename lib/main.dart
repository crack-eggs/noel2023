// main.dart
import 'package:flutter/material.dart';
import 'package:noel/presentation/pages/home_page.dart';

import 'package:noel/route.dart';
import 'package:noel/service/realtime_service.dart';
import 'package:noel/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/injection.dart';
import 'service/navigator_service.dart';

late SharedPreferences prefs;

void main() async {
  prefs = await SharedPreferences.getInstance();
  init();
  sl<RealtimeService>();
  AppRouter.setupRouter();
  UserService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: AppRouter.router.generator,
        title: 'Game App',
        home: const HomePage(),
        navigatorKey: sl<AppService>().topNavigationKey);
  }
}
