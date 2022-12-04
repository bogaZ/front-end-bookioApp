import 'dart:io';

import 'package:bookio2/page/penyedia/PemesananLangsung.dart';
import 'package:bookio2/page/penyedia/PemesananMelaluiAplikasi.dart';
import 'package:flutter/material.dart';

class PemesananPenyedia extends StatelessWidget {
  static const routeName = "/pemesananPenyedia";
  const PemesananPenyedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepOrange,
            title: Text("Pemesanan"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PemesananLangsung.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: null,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pemesanan Langsung',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            "Pemesanan secara langsung",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black26),
                          )
                        ],
                      ),

                      leading: Icon(
                        Icons.note_alt_outlined,
                        color: Colors.deepOrange,
                        size: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF303030),
                        size: 20,
                      ),
                      //tileColor: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, PemesananMelaluiAplikasi.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: null,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Melalui Aplikasi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            "Pemesanan melalui aplikasi",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black26),
                          )
                        ],
                      ),

                      leading: Icon(
                        Icons.phone_iphone_outlined,
                        color: Colors.deepOrange,
                        size: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF303030),
                        size: 20,
                      ),
                      //tileColor: Colors.black26,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
