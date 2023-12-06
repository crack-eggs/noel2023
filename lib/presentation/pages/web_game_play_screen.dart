import 'package:flutter/material.dart';

import '../../enums.dart';
import '../provider/web_game_provider.dart';
import '../shared/base_view.dart';

class WebGamePlayScreen extends StatefulWidget {
  const WebGamePlayScreen({Key? key, required this.matchId}) : super(key: key);
  final String matchId;

  @override
  State<WebGamePlayScreen> createState() => _WebGamePlayScreenState();
}

class _WebGamePlayScreenState extends State<WebGamePlayScreen>
    with
        SingleTickerProviderStateMixin,
        VMState<WebGameProvider, WebGamePlayScreen> {
  late AnimationController _controller;

  @override
  Widget createWidget(BuildContext context, WebGameProvider viewModel) {
    return WillPopScope(
      onWillPop: () async => false,
      child: consumer(
        builder: (BuildContext context, WebGameProvider viewModel, _) =>
            Scaffold(
                body: Column(
                  children: [
                    RotationTransition(
                      turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
                      child: const Icon(Icons.egg_outlined, size: 300),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.onUserBackToHome();
                          Navigator.pop(context);
                        },
                        child: const Text('Back')),
                    viewModel.lastEventType == EventType.getGift
                        ? Text('Countdown to close: ${viewModel.countdownToClose}')
                        : const SizedBox()
                  ],
                )),
      ),
    );
  }

  @override
  void onVMReady(WebGameProvider viewModel, BuildContext context) {
    viewModel.pop = () {
      Navigator.pop(context);
    };
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    viewModel.setController(_controller);
    viewModel.init(widget.matchId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
