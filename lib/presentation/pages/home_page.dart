import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/leaderboard_provider.dart';
import '../shared/base_view.dart';
import '../shared/qrcode_popup.dart';

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
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              String qrCodeData = "http://localhost:49430/#/login?match_id=123";
              showQrCodePopup(context, qrCodeData);
            },
            child: const Text('Show QR Code'),
          ),

          Consumer<WebHomeProvider>(
            builder: (_, vm, ___) => vm.leaderboard?.isNotEmpty == true?
              Column(
                    children: [
                      const Text('Leaderboard:'),
                      for (var player in vm.leaderboard!)
                        ListTile(
                          title: Text(player.displayName),
                          subtitle: Text('Score: ${player.score}'),
                        ),
                    ],
                  ) : const Text('Empty'),
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
