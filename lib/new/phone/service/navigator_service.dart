import 'package:flutter/material.dart';

class AppService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get topNavigationKey => _navigationKey;
}

class NavigationService {
  NavigationService(this.navigationKey);

  BuildContext? context;

  final GlobalKey<NavigatorState> navigationKey;

  void onStateNull() => throw FlutterError('Navigator state is null');
}
