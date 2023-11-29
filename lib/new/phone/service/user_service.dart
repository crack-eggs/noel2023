import 'dart:convert';

import 'package:noel/new/phone/data/models/user_model.dart';

import '../../main.dart';

class UserService {
  UserModel? _currentUser;

  // Singleton setup
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal() {
    _loadUserFromPrefs();
  }

  // Getter for the current user
  UserModel? get currentUser => _currentUser;

  // Save user method
  void saveUser(UserModel user) {
    _currentUser = user;
    _saveUserToPrefs();
    // Add logic to persist user data to storage/database as needed
  }

  // Load user data from SharedPreferences
  void _loadUserFromPrefs() {
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      print('UserService._loadUserFromPrefs');
      _currentUser =
          UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserToPrefs() async {
    await prefs.setString('user', jsonEncode(_currentUser!.toJson()));
  }
}
