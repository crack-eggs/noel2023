import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noel/cracker/cracker_play_screen.dart';
import 'package:noel/egg/egg_screen.dart';
import 'package:noel/qrCode/qr_code_component.dart';
import 'package:noel/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'enums.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: '611515699584-rh1qbc05q7df5beuajssulpqk7qjgqik.apps.googleusercontent.com',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

final supabase = SupabaseClient('https://urdghqpqgkdhmcoecmyb.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDExMzUyMTMsImV4cCI6MjAxNjcxMTIxM30.cZM2G8RvkA0CzznAAZNi7sGc0QDDviCQ7jjWRHpAUeU');
final gameChannel =  supabase.channel('game');

void main() async {
  print('main');
  WidgetsFlutterBinding.ensureInitialized();
  gameChannel.onEvents(
      'broadcast',
      ChannelFilter(
        event: EventType.start.name,
      ), (payload, [ref]) {
    print('EventType.start.name');
    print('payload: $payload');
  }).subscribe();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key}){
    final router = FluroRouter();
    AppRouter.router = router;
    AppRouter.configureRoutes();
    router.notFoundHandler = Handler(
      handlerFunc: (context, parameters) {
        print("Route not found: ${parameters['uri']}");
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      onGenerateRoute: AppRouter.router.generator,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Future<void> _handleSignIn() async {
    try {
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSignIn,
        tooltip: 'Increment',
        child: const Icon(Icons.login),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EggScreen()),
                );
              },
              child: const Text('Egg')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CrackerPlayScreen()),
                );
              },
              child: const Text('Cracker')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QRCodeScreen()),
                );
              },
              child: const Text('QrCode'))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
