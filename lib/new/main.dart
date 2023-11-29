// main.dart
import 'package:flutter/material.dart';
import 'package:noel/new/phone/di/injection.dart';
import 'package:noel/new/phone/presentation/pages/home_page.dart';
import 'package:noel/new/phone/presentation/provider/game_provider.dart';
import 'package:noel/new/phone/presentation/provider/leaderboard_provider.dart';
import 'package:noel/new/phone/presentation/provider/sign_in_google_provider.dart';
import 'package:noel/new/phone/presentation/provider/user_provider.dart';
import 'package:noel/new/phone/route.dart';
import 'package:noel/new/phone/service/user_service.dart';
import 'package:noel/new/phone/service/realtime_service.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(create: (_) => sl<GameProvider>()),
        ChangeNotifierProvider<UserProvider>(create: (_) => sl<UserProvider>()),
        ChangeNotifierProvider<LeaderboardProvider>(
            create: (_) => sl<LeaderboardProvider>()),
        ChangeNotifierProvider<SignInGoogleProvider>(
            create: (_) => sl<SignInGoogleProvider>()),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.router.generator,
        title: 'Game App',
        home: HomePage(),
      ),
    );
  }
}
