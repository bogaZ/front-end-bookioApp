import 'dart:convert';

import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/ButtonNavbar.dart';
import 'package:bookio2/widget/Sidebar.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class DaftarPenyewa extends StatefulWidget {
  const DaftarPenyewa({Key? key}) : super(key: key);

  @override
  _DaftarPenyewaState createState() => _DaftarPenyewaState();
}

class _DaftarPenyewaState extends State<DaftarPenyewa> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final retypePassword = TextEditingController();
  final nomorHp = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Sidebar(),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 30),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 400,
                    ),
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/Profil.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Text(
                            'Nama',
                            style: TextStyle(),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama tidak boleh dikosongi!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    //autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Nama Lengkap',
                                      hintStyle: TextStyle(
                                        color: Colors.black12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Periksa kembali email anda!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    //autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Colors.grey,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Email',
                                      hintStyle: TextStyle(
                                        color: Colors.black12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Password',
                                    style: TextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: password,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Periksa kembali password anda!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    //autofocus: true,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          }),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Ulangi Password',
                                    style: TextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: retypePassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Periksa kembali password anda!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    //autofocus: true,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Kembali Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Nomor Ponsel',
                                    style: TextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: nomorHp,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Periksa kembali nomor ponsel anda!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    //autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.phone_android_sharp,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Masukkan Nomor Ponsel',
                                      hintStyle: TextStyle(
                                        color: Colors.black12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrange, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      _formKey.currentState!.validate();
                                      register('/register/penyewa');
                                    },
                              child: Text(
                                _isLoading ? 'Mendaftar...' : 'Daftar',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 50,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah punya akun ? ',
                              textAlign: TextAlign.start,
                            ),
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPenyewa()),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.orange,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  register(String link) async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': name.text,
      'email': email.text,
      'nomor_hp': nomorHp.text,
      'password': password.text,
      'password_confirmation': retypePassword.text,
    };

    var res = await Network().auth(data, link);

    var body = json.decode(res.body);

    if (body['errors'] != null) {
      if (body['errors']['name'] != null) {
        _showMsg(body['errors']['name'][0].toString());
      } else if (body['errors']['email'] != null) {
        _showMsg(body['errors']['email'][0].toString());
      } else if (body['errors']['password'] != null) {
        _showMsg(body['errors']['password'][0].toString());
      } else if (body['errors']['nomor_hp'] != null) {
        _showMsg(body['errors']['nomor_hp'][0].toString());
      }
      setState(() {
        _isLoading = false;
      });
      return null;
    }

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      print(body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavbar(
            argument: 0,
          ),
        ),
      );
      _showMsg('Welcome' + body['user']['name']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
