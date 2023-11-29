// main.dart
import 'package:flutter/material.dart';
import 'package:noel/new/phone/di/injection.dart';
import 'package:noel/new/phone/presentation/pages/home_page.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game App',
      home: HomePage(),
    );
  }
}
