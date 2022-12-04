import 'dart:convert';

import 'package:bookio2/page/Login.dart';
import 'package:bookio2/page/OptionalUser.dart';
import 'package:bookio2/page/penyedia/Login.dart';
import 'package:bookio2/page/penyedia/Withdraw.dart';
import 'package:bookio2/provider/AutenticationProvider.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/ButtonNavbar.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawLoading extends StatefulWidget {
  const WithdrawLoading({Key? key}) : super(key: key);

  @override
  __WithdrawLoadingState createState() => __WithdrawLoadingState();
}

class __WithdrawLoadingState extends State<WithdrawLoading> {
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
      navigator: Withdraw(),
      durationInSeconds: 1,
    );
  }
}
