import 'dart:io';
import 'package:bookio2/page/PemesananDiproses.dart';
import 'package:bookio2/page/Profil.dart';
import 'package:flutter/material.dart';
import '../page/HomePage.dart';

@immutable
class BottomNavbar extends StatefulWidget {
  final int argument;
  static const nameRoute = "/navbar";
  const BottomNavbar({Key? key, required this.argument}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _BottomNavbarState createState() => _BottomNavbarState(argument: argument);
}

class _BottomNavbarState extends State<BottomNavbar> {
  int argument;
  _BottomNavbarState({required this.argument}) {
    _selectedIndex = argument;
  }
  int _selectedIndex = 0;
  //final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _widgetOptions = [
    HomePenyewa(),
    PemesananDiproses(),
    const Profil(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
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
          unselectedLabelStyle:
              const TextStyle(color: Colors.black45, fontSize: 12),
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(color: Colors.deepOrange, fontSize: 12),
        ),
      ),
    );
  }
}
