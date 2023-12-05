import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../enums.dart';
import '../provider/web_home_provider.dart';
import '../shared/base_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with VMState<WebHomeProvider, HomePage> {
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
                      'assets/home/egg_center.png',
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.loaded();
    });
    viewModel.watch(onEvent: () {

      Navigator.popAndPushNamed(context, '/web-game-play');
    });
  }

  void showQrCode() {
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
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'To verify yourself\nPlease scan this QR code with your phone',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    QrImageView(
                      data:
                          'https://sunny-arithmetic-f4b9c6.netlify.app/#/login?match_id=${viewModel.getUUID()}',
                      size: 220,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
