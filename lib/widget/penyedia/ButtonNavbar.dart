import 'dart:convert';
import 'dart:io';

import 'package:bookio2/page/PemesananDiproses.dart';
import 'package:bookio2/page/Profil.dart';
import 'package:bookio2/page/penyedia/FirstLogin/TambahAkunPembayaran.dart';
import 'package:bookio2/page/penyedia/HomePenyedia.dart';
import 'package:bookio2/page/penyedia/PemesananPenyedia.dart';
import 'package:bookio2/page/penyedia/ProfilePenyedia.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AutenticationProvider.dart';

class BottomNavbarPenyedia extends StatefulWidget {
  int argument;
  static const nameRoute = "/homePenyedia";
  BottomNavbarPenyedia({Key? key, required this.argument}) : super(key: key);

  @override
  _BottomNavbarPenyediaState createState() =>
      _BottomNavbarPenyediaState(argument: argument);
}

class _BottomNavbarPenyediaState extends State<BottomNavbarPenyedia> {
  int argument;
  _BottomNavbarPenyediaState({required this.argument}) {
    _selectedIndex = argument;
  }
  int _selectedIndex = 0;

  //final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _widgetOptions = [
    HomePenyedia(),
    PemesananPenyedia(),
    ProfilPenyedia()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        //key: scaffoldKey,
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: 'Pemesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.black45,
          unselectedLabelStyle: TextStyle(color: Colors.black45, fontSize: 12),
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.deepOrange, fontSize: 12),
        ),
      ),
    );
  }
}
