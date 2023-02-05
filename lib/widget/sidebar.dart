import 'package:bookio2/page/Login.dart';
import 'package:bookio2/page/penyedia/Login.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Login sebagai..?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black45,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPenyedia()));
              },
              child: Container(
                decoration: const BoxDecoration(),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Penyedia',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      Text(
                        "Login sebagai penyedia",
                        style: TextStyle(fontSize: 13, color: Colors.black26),
                      )
                    ],
                  ),

                  leading: const Icon(
                    Icons.login_outlined,
                    color: Colors.deepOrange,
                    size: 30,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF303030),
                    size: 20,
                  ),
                  //tileColor: Colors.black26,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPenyewa()));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: null,
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Penyewa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      Text(
                        "Login sebagai Penyewa",
                        style: TextStyle(fontSize: 13, color: Colors.black26),
                      )
                    ],
                  ),

                  leading: const Icon(
                    Icons.login_outlined,
                    color: Colors.deepOrange,
                    size: 30,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF303030),
                    size: 20,
                  ),
                  //tileColor: Colors.black26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
