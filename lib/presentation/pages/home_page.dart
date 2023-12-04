import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../enums.dart';
import '../provider/leaderboard_provider.dart';
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home/background_home.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/home/logo_home.png',
                width: 500,
                fit: BoxFit.fitWidth,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Image.asset(
                  'assets/home/egg_center.png',
                  width: 400,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 12,
              left: MediaQuery.of(context).size.width / 2 + 20,
              child: Image.asset(
                'assets/home/egg_1.png',
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 8,
              right: MediaQuery.of(context).size.width / 5 * 2 + 30,
              child: Image.asset(
                'assets/home/egg_2.png',
                width: 400,
                fit: BoxFit.fitWidth,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SvgPicture.asset(
                  'assets/home/start_button.svg',
                  width: 400,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _buildLeaderBoard(),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width/20,
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
    );
  }

  _buildLeaderBoard() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Image.asset(
            'assets/home/leaderboard.png',
            width: 300,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 130,
            child: Image.asset(
              'assets/home/leaderboard_text.png',
              fit: BoxFit.fitHeight,
              height: 24,
            ),
          ),
          Positioned(
            bottom: 230,
            left: 40,
            right: 0,
            child: consumer(
                builder: (BuildContext context, WebHomeProvider viewModel, _) =>
                    viewModel.state == ViewState.busy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _buildItemLeaderboard(
                            hammer: viewModel.leaderboard!.first.hammers,
                            name: viewModel.leaderboard!.first.displayName,
                            score:
                                viewModel.leaderboard!.first.score.toString(),
                            avatar: viewModel.leaderboard!.first.avatar,
                          )),
          )
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
            style: GoogleFonts.lilitaOne(
              textStyle: const TextStyle(color: Colors.white),
            )),
      ),
      subtitle: Row(
        children: [
          Image.asset(
            'assets/home/bua.png',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 2),
          Text(hammer.toString(),
              style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.white),
              )),
          const SizedBox(width: 8),
          Image.asset(
            'assets/home/caythong.png',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 2),
          Text(
            score.toString(),
            style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void onVMReady(WebHomeProvider viewModel, BuildContext context) {
    viewModel.fetchLeaderboard();
  }
}
