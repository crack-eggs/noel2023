import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../../domain/repositories/leaderboard_repository.dart';

class LeaderboardProvider extends ChangeNotifier {
  final LeaderboardRepository leaderboardRepository;

  LeaderboardProvider({required this.leaderboardRepository});

  List<UserModel> _leaderboard = [];
  List<UserModel> get leaderboard => _leaderboard;

  Future<void> fetchLeaderboard() async {
    try {
      _leaderboard = await leaderboardRepository.getLeaderboard();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching leaderboard: $e');
    }
  }
}

