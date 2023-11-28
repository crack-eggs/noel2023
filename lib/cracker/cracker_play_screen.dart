import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums.dart';
import '../main.dart';

class CrackerPlayScreen extends StatefulWidget {
  const CrackerPlayScreen({Key? key}) : super(key: key);

  @override
  State<CrackerPlayScreen> createState() => _CrackerPlayScreenState();
}

class _CrackerPlayScreenState extends State<CrackerPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            print('_CrackerPlayScreenState.build');
            gameChannel.send(
                type: RealtimeListenTypes.broadcast,
                event: EventType.start.name,
                payload: {'email': 'user!.email'});
          },
          child: const Text('Tap Tap'),
        ),
      ),
    );
  }
}
