import 'package:flutter/material.dart';
import 'package:noel/new/phone/enums.dart';
import 'package:noel/new/phone/presentation/shared/base_view.dart';
import 'package:noel/new/phone/service/user_service.dart';

import '../../route.dart';
import '../provider/user_provider.dart';
import '../shared/topup_popup.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with VMState<UserProvider, UserProfileScreen> {
  @override
  Widget createWidget(BuildContext context, UserProvider viewModel) {
    return Scaffold(
        body: consumer(
            builder: (BuildContext context, UserProvider viewModel, _) =>
                viewModel.state == ViewState.busy
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Text(
                              'Your point: ${UserService().currentUser?.score}'),
                          Text(
                              'Your hammers: ${UserService().currentUser?.hammers}'),
                          if (UserService().currentUser!.hammers > 0)
                            ElevatedButton(
                                onPressed: () {
                                  viewModel.onUserStartGame();
                                },
                                child: const Text('Start Game')),
                          if (UserService().currentUser!.hammers == 0)
                            ElevatedButton(
                                onPressed: () async {
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
                                child: const Text('Top-up'))
                        ],
                      )));
  }

  @override
  void onVMReady(UserProvider viewModel, BuildContext context) {
    viewModel.updateUser();
  }
}
