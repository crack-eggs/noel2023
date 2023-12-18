import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
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
    with TickerProviderStateMixin, VMState<WebGameProvider, WebGamePlayScreen> {
  late AnimationController _controller;
  late AnimationController _lightController;

  @override
  Widget createWidget(BuildContext context, WebGameProvider viewModel) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: consumer(
          builder: (BuildContext context, WebGameProvider viewModel, _) =>
              Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home/background_home.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  color: Colors.black45,
                ),
                if (viewModel.lastEventType == EventType.start ||
                    viewModel.lastEventType == EventType.startTap ||
                    viewModel.lastEventType == EventType.restartGame)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: RotationTransition(
                        turns:
                            Tween(begin: -0.02, end: 0.02).animate(_controller),
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          randomEggPath(),
                          height: 500,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                if (viewModel.lastEventType == EventType.getGift)
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        RotationTransition(
                          turns: Tween(begin: 0.0, end: 1.0)
                              .animate(_lightController),
                          child: Image.asset(
                            'assets/home/light.png',
                            height: 300,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        if (viewModel.lastGiftType == GiftType.jackpot)
                          Image.asset(
                            'assets/home/coffer.png',
                            height: 250,
                            fit: BoxFit.fitHeight,
                          ),
                        if (viewModel.lastGiftType == GiftType.empty)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/home/qr_popup.png',
                                height: 600,
                                fit: BoxFit.fitHeight,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  wishLists[
                                      Random().nextInt(wishLists.length - 1)],
                                  style: GoogleFonts.lilitaOne(fontSize: 35),
                                ),
                              )
                            ],
                          ),
                        if (viewModel.lastGiftType == GiftType.gift)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/home/thong4x.png',
                                height: 250,
                                fit: BoxFit.fitHeight,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text('+${viewModel.score}',
                                      style: GoogleFonts.lilitaOne(
                                        fontSize: 70,
                                        letterSpacing: 5,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 10
                                          ..color = primaryColor,
                                      )),
                                  Text(
                                    '+${viewModel.score}',
                                    style: GoogleFonts.lilitaOne(
                                      fontSize: 70,
                                      letterSpacing: 5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 20,
                  top: 40,
                  child: Image.asset(
                    'assets/home/logo_home.png',
                    fit: BoxFit.fitHeight,
                    height: 100,
                  ),
                ),
                Positioned(
                  right: 60,
                  top: 60,
                  child: Row(
                    children: [
                      if (viewModel.lastEventType == EventType.getGift)
                        Stack(
                          children: [
                            Text(
                                'Return to Home after \n${viewModel.countdownToClose} second(s)',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.lilitaOne(
                                  fontSize: 22,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 5
                                    ..color = primaryColor,
                                )),
                            Text(
                              'Return to Home after \n${viewModel.countdownToClose} second(s)',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.lilitaOne(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          viewModel.onUserBackToHome();
                        },
                        child: Image.asset(
                          'assets/home/close.png',
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                viewModel.lastEventType == EventType.getGift
                    ? Text('Countdown to close: ${viewModel.countdownToClose}')
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onVMReady(WebGameProvider viewModel, BuildContext context) {
    viewModel.pop = () {
      Navigator.pop(context);
    };
    _lightController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _lightController.repeat();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.repeat(reverse: true);
    viewModel.setController(_controller);
    viewModel.init(widget.matchId);
  }

  @override
  void dispose() {
    _lightController.dispose();
    viewModel.dispose();
    super.dispose();
  }
}
