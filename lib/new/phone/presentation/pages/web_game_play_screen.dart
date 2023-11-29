import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/web_game_provider.dart';

class WebGamePlayScreen extends StatefulWidget {
  const WebGamePlayScreen({Key? key}) : super(key: key);

  @override
  State<WebGamePlayScreen> createState() => _WebGamePlayScreenState();
}

class _WebGamePlayScreenState extends State<WebGamePlayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    Provider.of<WebGameProvider>(context, listen: false)
        .setController(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
      child: const Icon(Icons.egg_outlined, size: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
