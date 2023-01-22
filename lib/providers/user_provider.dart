import 'package:gpass/models/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider((ref) => UserProvider());

class UserProvider extends ChangeNotifier {
  User _user = User(
    name: '',
    deviceId: [],
    deviceDetails: '',
    password: '',
    token: '',
  );
  User get user => _user;

  void setUSer(String user) {
    _user = User.fromJson(user);
  }

  void setUserFromModel() {
    _user = user;
    notifyListeners();
  }
}
