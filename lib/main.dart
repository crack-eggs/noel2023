// main.dart
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:noel/presentation/pages/home_page.dart';

import 'package:noel/route.dart';
import 'package:noel/service/app_settings_service.dart';
import 'package:noel/service/event_in_app.dart';
import 'package:noel/service/realtime_service.dart';
import 'package:noel/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'constants.dart';
import 'di/injection.dart';
import 'service/navigator_service.dart';

late SharedPreferences prefs;
final dio = Dio(
  BaseOptions(baseUrl: 'https://ots.space/apps/crackeggs-2023/fn/v1', headers: {
    'Content-Type': 'application/json',
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDExMzUyMTMsImV4cCI6MjAxNjcxMTIxM30.cZM2G8RvkA0CzznAAZNi7sGc0QDDviCQ7jjWRHpAUeU',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDExMzUyMTMsImV4cCI6MjAxNjcxMTIxM30.cZM2G8RvkA0CzznAAZNi7sGc0QDDviCQ7jjWRHpAUeU'
  }),
);

void main() async {
  dio.interceptors.add(DioLogInterceptor());

  await googleSignIn.initWithParams(const SignInInitParameters(
    clientId:
        '611515699584-rh1qbc05q7df5beuajssulpqk7qjgqik.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  ));

  prefs = await SharedPreferences.getInstance();
  init();
  EventInApp();
  sl<RealtimeService>();
  AppRouter.setupRouter();

  UserService();
  AppSettings().fetch();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: AppRouter.router.generator,
        title: 'Game App',
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        initialRoute: '/login?match_id=${const Uuid().v4()}',
        home: !isWebMobile ? Container() : const HomePage(),

        // home: isWebMobile ? Container() : const HomePage(),
        builder: (context, widget) {
          Widget error = const Text('...rendering error...');
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: Center(child: error));
          }
          ErrorWidget.builder = (errorDetails) => error;
          if (widget != null) return widget;
          throw StateError('widget is null');
        },
        navigatorKey: sl<AppService>().topNavigationKey);
  }
}
