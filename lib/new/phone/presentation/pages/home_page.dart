import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/game_provider.dart';
import '../provider/user_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final gameProvider = Provider.of<GameProvider>(context);
    final user = userProvider.user;
    final game = gameProvider.game;

    // Your UI code here
    return Container();
  }
}
