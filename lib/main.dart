import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // Theo dõi sự kiện lắc
    accelerometerEventStream().listen((AccelerometerEvent event) {
      // Kiểm tra nếu thiết bị được lắc
      if (event.x.abs() > 12.0 || event.y.abs() > 12.0 || event.z.abs() > 12.0) {
        // Thực hiện hành động rung ở đây
        // Ví dụ: rung điện thoại
        vibrate();
      }
    });
  }

  void vibrate() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shake Detection'),
      ),
      body: const Center(
        child: Text('Lắc để thử nghiệm rung điện thoại.'),
      ),
    );
  }
}
