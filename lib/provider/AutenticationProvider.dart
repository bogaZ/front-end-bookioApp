import 'dart:convert';

import 'package:bookio2/page/OptionalUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticationProvider with ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  bool _isPenyedia = false;
  bool get isPenyedia => _isPenyedia;
  set isPenyedia(bool value) {
    _isPenyedia = value;
    notifyListeners();
  }

  void cekLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var userJson = localStorage.getString('user').toString();
    var user = jsonDecode(userJson);
    if (token != null && user['level'] == 'penyedia') {
      _isLogin = true;
      _isPenyedia = true;
    }
    if (token != null) {
      _isLogin = true;
    }
    print(_isLogin);
    print(_isPenyedia);
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
