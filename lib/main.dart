import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
        apiKey: "AIzaSyA49VtylB5AQMPbAeQftDxjziUl4ocQ058",
        authDomain: "one-crack-eggs.firebaseapp.com",
        projectId: "one-crack-eggs",
        storageBucket: "one-crack-eggs.appspot.com",
        messagingSenderId: "611515699584",
        appId: "1:611515699584:web:a4c40321393334ebceb165"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 500),
  //   );
  //   ShakeDetector detector = ShakeDetector.autoStart(
  //       onPhoneShake: () {
  //         // Do stuff on phone shake
  //         _count++;
  //         setState(() {
  //         });
  //       }
  //   );
  //   detector.startListening();
  // }
  //
  //
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       Text(_count.toString()),
  //       SizedBox(
  //         width: 300 ,
  //         height: 300,
  //         child: RotationTransition(
  //           turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
  //           child: GestureDetector(onTap:(){
  //             print('_MyHomePageState.build');
  //                 FirebaseFirestore.instance.collection('test').add({"test":"test"});
  //           },child: const Icon(Icons.egg_outlined, size: 300)),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

}