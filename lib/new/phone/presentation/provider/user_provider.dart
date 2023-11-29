import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? _user;

  UserEntity? get user => _user;

  void setUser(UserEntity newUser) {
    _user = newUser;
    notifyListeners();
  }
}
