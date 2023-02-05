import 'dart:convert';

import 'package:bookio2/models/User.dart';
import 'package:bookio2/page/Profil.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/button_navbar.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  List<User> _dataUser = [
    User(
        idUser: "0",
        namaUser: 'Budi Harsono',
        email: "budi@gmail.com",
        noHp: "089776554332",
        token: "qwer12345")
  ];
  List<User> get dataUser => _dataUser;

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => _userData;
  set userData(Map<String, dynamic> value) {
    _userData = value;
    notifyListeners();
  }

  Map<String, dynamic> _rekening = {};
  Map<String, dynamic> get rekening => _rekening;
  set rekening(Map<String, dynamic> value) {
    _rekening = value;
    notifyListeners();
  }

  getUserInfo() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var userJson = localStorage.getString('user').toString();
    // var user = json.decode(userJson);
    var res = await Network().getData('/akun/show');
    var body = jsonDecode(res.body);
    _userData = body['data'];
    _rekening = body['data_bank'];
    print(body);
  }

  updateUser(var data, String link, BuildContext context) async {
    var res = await Network().putData(data, '/akun/update');
    var body = jsonDecode(res.body);
    if (body['message'] == 'Update profile berhasil!') {
      if (link == 'penyewa') {
        _showMsg(body['message'], context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavbar(
                      argument: 2,
                    )));
      } else {
        _showMsg(body['message'], context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavbarPenyedia(
                      argument: 2,
                    )));
      }
    } else {
      _showMsg(body['message'], context);
    }
  }

  updatePassword(var data, BuildContext context, String link) async {
    var res = await Network().putData(data, '/change/password');
    var body = jsonDecode(res.body);
    _showMsg(body['message'], context);
    if (body['success']) {
      if (link == 'penyewa') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavbar(
                      argument: 2,
                    )));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavbarPenyedia(
                      argument: 2,
                    )));
      }
    }
  }

  _showMsg(msg, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  updateRekening(var data, BuildContext context) async {
    var res = await Network().putData(data, '/pembayaran/penyedia/update');
    var body = jsonDecode(res.body);
    print(body);
    _showMsg(body['message'], context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavbarPenyedia(
                  argument: 2,
                )));
  }
}
