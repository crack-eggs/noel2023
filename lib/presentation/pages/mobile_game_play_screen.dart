import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noel/enums.dart';
import 'package:noel/utils/toast.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../service/user_service.dart';
import '../provider/mobile_game_provider.dart';
import '../shared/base_view.dart';

class MobileGamePlayScreen extends StatefulWidget {
  const MobileGamePlayScreen({Key? key, required this.matchId})
      : super(key: key);
  final String matchId;

  @override
  State<MobileGamePlayScreen> createState() => _MobileGamePlayScreenState();
}

class _MobileGamePlayScreenState extends State<MobileGamePlayScreen>
    with
        VMState<MobileGameProvider, MobileGamePlayScreen>,
        SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget createWidget(BuildContext context, MobileGameProvider viewModel) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/mobile/bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: consumer(
        builder: (BuildContext context, MobileGameProvider vm, _) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 14,
            ),
            _buildHeader(),
            _buildBanner(),
            if (viewModel.stateGame == StateGame.start &&
                (UserService().currentUser!.hammers >= 0))
              viewModel.state == ViewState.busy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        _buildPower(),
                        const SizedBox(
                          height: 40,
                        ),
                        _buildHammer(),
                        const SizedBox(
                          height: 100,
                        ),
                        _buildTap(),
                      ],
                    ),
            if (viewModel.stateGame == StateGame.end)
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Image.asset(
                        'assets/mobile/popup.png',
                        height: 240,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Image.asset(
                      (UserService().currentUser!.hammers > 0)
                          ? 'assets/mobile/more_text.png'
                          : 'assets/mobile/topup_text.png',
                      height:
                          (UserService().currentUser!.hammers > 0) ? 60 : 100,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      bottom: -15,
                      right: 0,
                      left: 0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: ElevatedButton(
                          onPressed: () {
                            print('_MobileGamePlayScreenState.createWidget');
                            if (UserService().currentUser!.hammers > 0) {
                              viewModel.onUserContinue(
                                onFailure: () {
                                  AppToast.showError(
                                      "Game id not valid, please try again with another id!");
                                },
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (UserService().currentUser!.hammers > 0)
                                  ? 'Play'
                                  : 'TopUp',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const Expanded(child: SizedBox()),
            Image.asset(
              'assets/mobile/bottom.png',
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildTap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            viewModel.onUserTap();
          },
          child: Image.asset(
            'assets/mobile/btn_default.png',
            width: 100,
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.onUserTap();
          },
          child: Image.asset(
            'assets/mobile/btn_default.png',
            width: 100,
          ),
        ),
      ],
    );
  }

  Widget _buildHammer() {
    return RotationTransition(
      alignment: Alignment.bottomRight,
      turns: Tween(begin: -0.1, end: 0.02).animate(_controller),
      child: Image.asset(
        'assets/home/bua4x.png',
        width: 120,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildPower() {
    return SizedBox(
      width: 250,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Image.asset(
              'assets/mobile/power_border.png',
              width: 230,
              height: 32,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Image.asset(
                'assets/mobile/full_power.png',
                width: (220 * viewModel.countTap / 30),
                height: 22,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Image.asset(
              'assets/mobile/flash.png',
              width: 45,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          'assets/mobile/banner.png',
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            width: 220,
            child: Text(
                TiengViet.parse(UserService().currentUser?.displayName ?? '')
                    .toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 24),
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const SizedBox(
          width: 32,
        ),
        Image.asset(
          'assets/home/caythong.png',
          width: 24,
        ),
        const SizedBox(width: 2),
        Text(
          (UserService().currentUser?.score ?? '0').toString(),
          style: GoogleFonts.lilitaOne(
              textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const Expanded(child: SizedBox()),
        Image.asset(
          'assets/home/bua.png',
          width: 24,
        ),
        const SizedBox(width: 2),
        Text((UserService().currentUser?.hammers ?? '0').toString(),
            style: GoogleFonts.lilitaOne(
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
            )),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void onVMReady(MobileGameProvider viewModel, BuildContext context) {
    viewModel.init(widget.matchId);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    viewModel.setController(_controller);
  }
}
