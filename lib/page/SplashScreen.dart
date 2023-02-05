import 'dart:convert';

import 'package:bookio2/page/Login.dart';
import 'package:bookio2/page/OptionalUser.dart';
import 'package:bookio2/page/penyedia/Login.dart';
import 'package:bookio2/provider/AutenticationProvider.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/button_navbar.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'penyedia/FirstLogin/TambahAkunPembayaran.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLogin = false;
  bool _isPenyedia = false;
  bool _pembayaran = false;
  @override
  void initState() {
    cekLogin();
    super.initState();
  }

  void cekLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var userJson = localStorage.getString('user').toString();
    var user = jsonDecode(userJson);
    if (token != null && user['level'] == 'penyedia') {
      setState(() {
        _isLogin = true;
        _isPenyedia = true;
      });
      getAkunPembayaran();
    } else if (token != null) {
      setState(() {
        _isLogin = true;
      });
    }
  }

  void getAkunPembayaran() async {
    var res = await Network().getData('/pembayaran/penyedia');
    var body = jsonDecode(res.body);

    if (body['success']) {
      setState(() {
        _pembayaran = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/images/Profil.png',
        fit: BoxFit.contain,
      ),
      logoSize: 150,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Colors.grey,
      navigator: _isLogin
          ? _isPenyedia
              ? _pembayaran
                  ? BottomNavbarPenyedia(argument: 0)
                  : TambahAkunPembayaran()
              : BottomNavbar(
                  argument: 0,
                )
          : OptionalUser(),
      durationInSeconds: 3,
    );
  }
}
