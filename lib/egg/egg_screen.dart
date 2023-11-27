import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EggScreen extends StatefulWidget {
  const EggScreen({Key? key}) : super(key: key);

  @override
  State<EggScreen> createState() => _EggScreenState();
}

class _EggScreenState extends State<EggScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controller.forward();
    FirebaseFirestore.instance.collection('test').snapshots().listen((event) {
      print('_EggScreenState.initState');
      _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
      child: const Icon(Icons.egg_outlined, size: 300),
    );
  }
}
