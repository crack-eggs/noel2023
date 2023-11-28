import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:noel/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../router/router.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  StreamSubscription? stream;

  @override
  void initState() {
    insertSupabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: QrImageView(
        data: 'http://localhost:10000/#/signin?matchId=1234567890',
        version: QrVersions.auto,
        size: 200.0,
      ),
    ));
  }

  void insertSupabase() async {
    stream ??= supabase
        .from('match_detail')
        .stream(primaryKey: ['id'])
        .eq('match_id', '1234567890')
        .listen((event) {
      AppRouter.router.navigateTo(context, "/match", transition: TransitionType.fadeIn);
    });
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }
}