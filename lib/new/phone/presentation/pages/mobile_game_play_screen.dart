import 'package:flutter/material.dart';
import 'package:noel/new/phone/enums.dart';
import 'package:provider/provider.dart';

import '../../service/user_service.dart';
import '../provider/mobile_game_provider.dart';
import '../shared/base_view.dart';

class MobileGamePlayScreen extends StatefulWidget {
  const MobileGamePlayScreen({Key? key}) : super(key: key);

  @override
  State<MobileGamePlayScreen> createState() => _MobileGamePlayScreenState();
}

class _MobileGamePlayScreenState extends State<MobileGamePlayScreen>
    with VMState<MobileGameProvider, MobileGamePlayScreen> {
  @override
  Widget createWidget(BuildContext context, MobileGameProvider viewModel) {
    return Scaffold(
        body: consumer(
      builder: (BuildContext context, MobileGameProvider vm, _) =>
          viewModel.state == ViewState.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Text('Your point: ${UserService().currentUser?.score}'),
                    Text('Your hammers: ${UserService().currentUser?.hammers}'),
                    if (viewModel.stateGame == StateGame.start &&
                        (UserService().currentUser!.hammers > 0))
                      ElevatedButton(
                        onPressed: () {
                          viewModel.onUserTap();
                        },
                        child: const Text('Tap Tap'),
                      ),
                    if (viewModel.stateGame == StateGame.end &&
                        (UserService().currentUser!.hammers > 0))
                      ElevatedButton(
                        onPressed: () {
                          viewModel.onUserContinue();
                        },
                        child: const Text('Continue'),
                      ),
                  ],
                ),
    ));
  }

  @override
  void onVMReady(MobileGameProvider viewModel, BuildContext context) {
    viewModel.onUserStartTap();
  }
}
