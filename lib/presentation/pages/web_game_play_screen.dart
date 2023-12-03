import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/web_game_provider.dart';
import '../shared/base_view.dart';

class WebGamePlayScreen extends StatefulWidget {
  const WebGamePlayScreen({Key? key}) : super(key: key);

  @override
  State<WebGamePlayScreen> createState() => _WebGamePlayScreenState();
}

class _WebGamePlayScreenState extends State<WebGamePlayScreen>
    with
        SingleTickerProviderStateMixin,
        VMState<WebGameProvider, WebGamePlayScreen> {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
      child: const Icon(Icons.egg_outlined, size: 300),
    );
  }

  @override
  Widget createWidget(BuildContext context, WebGameProvider viewModel) {
    return RotationTransition(
      turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
      child: const Icon(Icons.egg_outlined, size: 300),
    );
  }

  @override
  void onVMReady(WebGameProvider viewModel, BuildContext context) {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    viewModel
        .setController(_controller);
  }
}