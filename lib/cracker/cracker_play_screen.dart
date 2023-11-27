import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            FirebaseFirestore.instance.collection('test').add({"test":"test"});
          },
          child: const Text('Tap Tap'),
        ),
      ),
    );
  }
}
