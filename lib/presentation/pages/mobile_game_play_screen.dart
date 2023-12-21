import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:noel/enums.dart';
import 'package:noel/service/sound_service.dart';
import 'package:noel/utils/toast.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../service/user_service.dart';
import '../provider/mobile_game_provider.dart';
import '../shared/base_view.dart';
import '../shared/topup_popup.dart';

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                          _buildPower(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          _buildHammer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                          ),
                          if (viewModel.stateGame == StateGame.start)
                            _buildTap(),
                        ],
                      ),
              if (viewModel.stateGame == StateGame.end)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 16, right: 0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/mobile/popup.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100, right: 20, bottom: 40),
                      child: Text(
                        (UserService().currentUser!.hammers > 0)
                            ? 'Smash more\nEggs?'.toUpperCase()
                            : 'Run out of hammers.\nwant more?'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lilitaOne(
                          textStyle: TextStyle(
                            color: Colors.yellow,
                            fontSize: (UserService().currentUser!.hammers > 0)
                                ? 40
                                : 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (viewModel.stateGame == StateGame.end)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      print('_MobileGamePlayScreenState.createWidget');
                      if (UserService().currentUser!.hammers > 0) {
                        viewModel.onUserContinue(
                          onFailure: () {
                            AppToast.showError(
                                "Game id not valid, please try again with another id!");
                          },
                        );
                      } else {
                        final number = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const TopUpPopup();
                          },
                        );
                        if (number != null) {
                          await showDialog(
                            builder: (BuildContext context) {
                              return ConfirmPopUp(number: number);
                            },
                            context: context,
                          );
                          await viewModel.onUserTopUp(number);
                          viewModel.onUserContinue(
                            onFailure: () {
                              AppToast.showError(
                                  "Game id not valid, please try again with another id!");
                            },
                          );
                        }
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
              const Expanded(child: SizedBox()),
              Image.asset(
                'assets/mobile/bottom.png',
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildTap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder<PlayerState>(
          stream: SoundService().tapPlayer.playerStateStream,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                SoundService().tapPlayer.play();
                viewModel.onUserTap(onFailure: (String error) {
                  AppToast.showError(error);
                });
              },
              child: Image.asset(
                'assets/mobile/btn_default.png',
                width: MediaQuery.of(context).size.width / 4,
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            SoundService().tapPlayer
              ..seek(Duration.zero)
              ..play();
            viewModel.onUserTap(onFailure: (String error) {
              AppToast.showError(error);
            });
          },
          child: Image.asset(
            'assets/mobile/btn_default.png',
            width: MediaQuery.of(context).size.width / 4,
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
        width: 100,
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
        GestureDetector(
          onTap: () async {
            final number = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const TopUpPopup();
              },
            );
            if (number != null) {
              viewModel.onUserTopUp(number);
              showDialog(
                builder: (BuildContext context) {
                  return ConfirmPopUp(number: number);
                },
                context: context,
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.yellow[700]),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
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
