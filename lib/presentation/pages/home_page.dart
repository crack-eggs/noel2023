import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:noel/service/sound_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../constants.dart';
import '../../route.dart';
import '../provider/web_home_provider.dart';
import '../shared/base_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with VMState<WebHomeProvider, HomePage>, SingleTickerProviderStateMixin {
  late AnimationController _lightController;

  @override
  Widget createWidget(BuildContext context, WebHomeProvider viewModel) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: consumer(
          builder: (BuildContext context, WebHomeProvider viewModel, _) =>
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
                AnimatedPositioned(
                  left: 0,
                  right: 0,
                  top: viewModel.isLoaded ? 0 : -250,
                  duration: const Duration(milliseconds: 800),
                  child: Image.asset(
                    'assets/home/logo_home.png',
                    height: 250,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Image.asset(
                      'assets/home/egg_center_1.png',
                      height: 500,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 12,
                  left: MediaQuery.of(context).size.width / 2 + 80,
                  child: Image.asset(
                    'assets/home/egg_1.png',
                    width: 250,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 7,
                  right: MediaQuery.of(context).size.width / 5 * 2 + 30,
                  child: Image.asset(
                    'assets/home/egg_2.png',
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom:
                            viewModel.btnSize == WebHomeProvider.btnLargeSize
                                ? 12
                                : 20),
                    child: GestureDetector(
                      onTap: () async {
                        SoundService().webBackgroundPlayer.seek(Duration.zero);
                        SoundService().webBackgroundPlayer.play();
                        viewModel
                            .changeSizeButton(WebHomeProvider.btnSmallSize);
                        await Future.delayed(const Duration(milliseconds: 100));
                        viewModel
                            .changeSizeButton(WebHomeProvider.btnLargeSize);
                        showQrCode();
                      },
                      child: SvgPicture.asset(
                        'assets/home/start_button.svg',
                        height: viewModel.btnSize,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildLeaderBoard(),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 20,
                  top: 40,
                  child: Image.asset(
                    'assets/home/OTSV.png',
                    fit: BoxFit.fitWidth,
                    width: 100,
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 25,
                  top: 40,
                  child: Row(
                    children: [
                      ControlButtons(SoundService().webBackgroundPlayer),
                      GestureDetector(
                        onTap: () {
                          showTutorial();
                        },
                        child: SvgPicture.asset(
                          'assets/home/tutorial.svg',
                          fit: BoxFit.fitWidth,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                if (viewModel.settings != null)
                  Positioned(
                    left: 0,
                    bottom: 0,
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
                        Image.asset(
                          'assets/home/coffer.png',
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                        Text('+${viewModel.settings!.jackpot}',
                            style: GoogleFonts.lilitaOne(
                              fontSize: 40,
                              letterSpacing: 5,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 10
                                ..color = primaryColor,
                            )),
                        Text(
                          '+${viewModel.settings!.jackpot}',
                          style: GoogleFonts.lilitaOne(
                            fontSize: 40,
                            letterSpacing: 5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLeaderBoard() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Image.asset(
            'assets/home/leaderboard.png',
            height: 500,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 125,
            child: Image.asset(
              'assets/home/leaderboard_text.png',
              fit: BoxFit.fitHeight,
              height: 24,
            ),
          ),
          Positioned(
              top: 220,
              left: 40,
              right: 0,
              child: consumer(
                builder: (BuildContext context, WebHomeProvider viewModel, _) =>
                    viewModel.leaderboard == null
                        ? const SizedBox()
                        : SizedBox(
                            height: 230,
                            child: ListView.separated(
                              itemCount: viewModel.leaderboard!.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return _buildItemLeaderboard(
                                  hammer: viewModel.leaderboard![index].hammers,
                                  name:
                                      viewModel.leaderboard![index].displayName,
                                  score: viewModel.leaderboard![index].score
                                      .toString(),
                                  avatar: viewModel.leaderboard![index].avatar,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 12,
                                );
                              },
                            ),
                          ),
              ))
        ],
      ),
    );
  }

  _buildItemLeaderboard(
      {required int hammer,
      required String name,
      required String score,
      required String avatar}) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          avatar,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(TiengViet.parse(name).toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lilitaOne(
              textStyle: const TextStyle(color: Colors.white),
            )),
      ),
      subtitle: Row(
        children: [
          Image.asset(
            'assets/home/bua.png',
            width: 22,
          ),
          const SizedBox(width: 2),
          Text(hammer.toString(),
              style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.white, fontSize: 18),
              )),
          const SizedBox(width: 8),
          Image.asset(
            'assets/home/caythong.png',
            width: 22,
          ),
          const SizedBox(width: 2),
          Text(
            score.toString(),
            style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  void onVMReady(WebHomeProvider viewModel, BuildContext context) {
    viewModel.init();
    _lightController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.loaded();
      viewModel.watch(onEvent: () async {
        if (_ctxPopup != null) Navigator.pop(_ctxPopup!);

        await AppRouter.router
            .navigateTo(context, '/web-game-play?match_id=${viewModel.uuid}');
      });
      _lightController.repeat();
    });
  }

  void showTutorial() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/home/tutorial_popup.png',
                height: 700,
                fit: BoxFit.fitHeight,
              )),
        );
      },
    );
  }

  BuildContext? _ctxPopup;

  void showQrCode() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        _ctxPopup = ctx;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              print('_HomePageState.showQrCode');
              Navigator.pop(ctx);
            },
            child: Container(
              width: 1300,
              height: 650,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage('assets/home/qr_popup.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Hi!\nPlease scan this QR code to join the game!\n\nNote: The game supports only one player at a time\nPlease wait for the next turn.\nThank you',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  QrImageView(
                    data:
                        'https://otsv-xmas.netlify.app/#/login?match_id=${viewModel.getUUID()}',
                    size: 220,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    _ctxPopup = null;
  }

  @override
  void dispose() {
    _lightController.dispose();
    viewModel.dispose();
    super.dispose();
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            print('ControlButtons.build');

            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 50.0,
                height: 50.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(
                  Icons.play_arrow_outlined,
                  color: Colors.yellow[600],
                ),
                iconSize: 50,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(
                  Icons.pause,
                  color: Colors.yellow[600],
                ),
                iconSize: 50,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(
                  Icons.replay,
                  color: Colors.yellow[600],
                ),
                iconSize: 50.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
      ],
    );
  }
}
