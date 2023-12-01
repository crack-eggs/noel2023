// main.dart
import 'package:flutter/material.dart';
import 'package:noel/new/phone/di/injection.dart';
import 'package:noel/new/phone/presentation/pages/home_page.dart';

import 'package:noel/new/phone/route.dart';
import 'package:noel/new/phone/service/navigator_service.dart';
import 'package:noel/new/phone/service/user_service.dart';
import 'package:noel/new/phone/service/realtime_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
