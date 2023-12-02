import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noel/utils/list_exts.dart';

import '../../constants.dart';
import '../data/models/user_model.dart';
import '../di/injection.dart';
import '../main.dart';
import 'navigator_service.dart';

class UserService {
  UserModel? _currentUser;

  // Singleton setup
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal() {
    print('UserService._internal');
    _loadUserFromPrefs();
  }

  // Getter for the current user
  UserModel? get currentUser => _currentUser;

  // Save user method
  Future<void> saveUser(UserModel user) async {
    print('UserService.saveUser');
    _currentUser = user;
    print('currentUser: ${currentUser?.email}');
    await _saveUserToPrefs();
    // Add logic to persist user data to storage/database as needed
  }

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

  Future<void> fetch(List<UserModel> newUser) async {
    if (newUser.isEmpty) {
      Navigator.popUntil(
          sl<NavigationService>().context!, ModalRoute.withName('/'));
    }
    await saveUser(newUser.firstOrError());
  }
}
