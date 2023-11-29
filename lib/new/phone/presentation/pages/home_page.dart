// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/leaderboard_provider.dart';
import '../shared/qrcode_popup.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          // Your existing UI code here

          // Button to show QR code popup
          ElevatedButton(
            onPressed: () {
              String qrCodeData = "http://localhost:49430/#/login?match_id=123";
              showQrCodePopup(context, qrCodeData);
            },
            child: const Text('Show QR Code'),
          ),

          // Leaderboard
          ElevatedButton(
            onPressed: () {
              Provider.of<LeaderboardProvider>(context, listen: false)
                  .fetchLeaderboard();
            },
            child: const Text('Fetch Leaderboard'),
          ),
          Consumer<LeaderboardProvider>(
            builder: (_, vm,___) => Column(
              children: [
                const Text('Leaderboard:'),
                for (var player in vm.leaderboard)
                  ListTile(
                    title: Text(player.displayName),
                    subtitle: Text('Score: ${player.score}'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
