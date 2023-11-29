import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/mobile_game_provider.dart';

class MobileGamePlayScreen extends StatefulWidget {
  const MobileGamePlayScreen({Key? key}) : super(key: key);

  @override
  State<MobileGamePlayScreen> createState() => _MobileGamePlayScreenState();
}

class _MobileGamePlayScreenState extends State<MobileGamePlayScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (count == 0) {
              Provider.of<MobileGameProvider>(context, listen: false)
                  .onUserStartTap();
            }

            if (count == 10) {
              Provider.of<MobileGameProvider>(context, listen: false)
                  .onUserStopTap();
            }
            count++;
          },
          child: const Text('Tap Tap'),
        ),
      ),
    );
  }
}
