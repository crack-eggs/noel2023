import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noel/enums.dart';
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
                                  viewModel.onUserStartGame(widget.matchId,
                                      onFailure: () {
                                    AppToast.showError(
                                        "Game id not valid, please try again with another id!");
                                  });
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
