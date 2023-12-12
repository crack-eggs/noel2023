import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noel/enums.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../constants.dart';
import '../../service/user_service.dart';
import '../../utils/toast.dart';
import '../provider/user_provider.dart';
import '../shared/base_view.dart';
import '../shared/topup_popup.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key, required this.matchId}) : super(key: key);
  final String matchId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with VMState<UserProvider, UserProfileScreen> {
  @override
  Widget createWidget(BuildContext context, UserProvider viewModel) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/mobile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: consumer(
          builder: (BuildContext context, UserProvider viewModel, _) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  _buildHeader(),
                  _buildBanner(),
                  const SizedBox(
                    height: 40,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        'assets/mobile/snow.png',
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Image.asset(
                          'assets/mobile/egg_group.png',
                          fit: BoxFit.fitWidth,
                          width: 350,
                        ),
                      ),
                      if (viewModel.state == ViewState.busy)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        Visibility(
                          visible: (UserService().currentUser!.hammers > 0),
                          child: GestureDetector(
                            onTap: () {
                              viewModel.onUserStartGame(widget.matchId,
                                  onFailure: () {
                                AppToast.showError(
                                    "Game id not valid, please try again with another id!");
                              });
                            },
                            child: Image.asset(
                              'assets/mobile/button_start.png',
                              height: 70,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Image.asset(
                    'assets/mobile/bottom.png',
                    fit: BoxFit.fill,
                  ),
                ],
              )),
    ));
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
          width: 26,
        ),
        const SizedBox(width: 2),
        Text(
          (UserService().currentUser?.score ?? '0').toString(),
          style: GoogleFonts.lilitaOne(
              textStyle: const TextStyle(color: Colors.white, fontSize: 24)),
        ),
        const Expanded(child: SizedBox()),
        Image.asset(
          'assets/home/bua.png',
          width: 26,
        ),
        const SizedBox(width: 2),
        Text((UserService().currentUser?.hammers ?? '0').toString(),
            style: GoogleFonts.lilitaOne(
              textStyle: const TextStyle(color: Colors.white, fontSize: 24),
            )),
        if (UserService().currentUser?.hammers == 0)
          GestureDetector(
            onTap: () async {
              final number = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TopUpPopup();
                },
              );
              if (number != null) {
                viewModel.onUserTopUp(number);
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
  void onVMReady(UserProvider viewModel, BuildContext context) {
    viewModel.updateUser();
  }
}
