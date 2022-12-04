import 'dart:convert';

import 'package:bookio2/page/penyedia/InformasiPembayaran.dart';
import 'package:bookio2/page/penyedia/InformasiPribadiPenyedia.dart';
import 'package:bookio2/page/penyedia/Login.dart';
import 'package:bookio2/page/penyedia/UbahPasswordPenyedia.dart';
import 'package:bookio2/provider/AutenticationProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPenyedia extends StatefulWidget {
  static const routeName = "/profilePenyedia";
  const ProfilPenyedia({Key? key}) : super(key: key);

  @override
  _ProfilPenyediaState createState() => _ProfilPenyediaState();
}

class _ProfilPenyediaState extends State<ProfilPenyedia> {
  PesanKonfirmasi(BuildContext context) {
    Widget okButton = Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          onPressed: () {
            logout();
            Provider.of<UserProvider>(context, listen: false);
            Provider.of<StudioProvider>(context, listen: false);
          },
          child: Text('Ok')),
    );
    Widget cancelButton = Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Batal')),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        "Perhatian",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text("Logout Akun..?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          backgroundColor: Colors.deepOrange,
          title: Text('Profile'),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, _) {
          return FutureBuilder(
              future: userProvider.getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Container(
                      width: 450,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Container(
                              //   height: 50,
                              //   width: 50,
                              //   decoration: BoxDecoration(
                              //       color: Colors.black12,
                              //       borderRadius: BorderRadius.circular(50)),
                              // ),
                              // SizedBox(
                              //   width: 20,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProvider.userData['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    userProvider.userData['nomor_hp'],
                                    style: TextStyle(color: Colors.black38),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Akun'),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, InformasiPribadiPenyedia.routeName,
                                  arguments: userProvider);
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
                                title: Text(
                                  'Informasi Pribadi',
                                ),
                                leading: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF303030),
                                  size: 20,
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
                                  context, InformasiPembayaran.routeName,
                                  arguments: userProvider);
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
                                title: Text(
                                  'Informasi Pembayaran',
                                ),
                                leading: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Color(0xFF303030),
                                  size: 20,
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
                                  context, UbahPasswordPenyedia.routeName);
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
                                title: Text(
                                  'Ubah Password',
                                ),
                                leading: Icon(
                                  Icons.lock_sharp,
                                  color: Color(0xFF303030),
                                  size: 20,
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
                              PesanKonfirmasi(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginPenyewa()));
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
                                title: Text(
                                  'Logout',
                                ),
                                leading: Icon(
                                  Icons.logout_outlined,
                                  color: Color(0xFF303030),
                                  size: 20,
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
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPenyedia()));
    }
  }
}
