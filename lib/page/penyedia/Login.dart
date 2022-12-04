import 'dart:convert';
import 'dart:io';

import 'package:bookio2/page/SplashScreen.dart';
import 'package:bookio2/page/penyedia/Daftar.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/Sidebar.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPenyedia extends StatefulWidget {
  const LoginPenyedia({Key? key}) : super(key: key);

  @override
  _LoginPenyediaState createState() => _LoginPenyediaState();
}

class _LoginPenyediaState extends State<LoginPenyedia> {
  //final scaffoldKey = GlobalKey<ScaffoldState>();
  bool validatorEmail = true;
  String errorEmail = '';
  bool validatePassword = true;
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        //key: scaffoldKey,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
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
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/images/profilCrop.png',
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_pin_circle_rounded,
                                  size: 24,
                                  color: Colors.deepOrange,
                                ),
                                Text(
                                  "Penyedia Studio",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      //autofocus: true,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.grey,
                                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
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
                                        // Navigator.pushNamed(context,
                                        //     BottomNavbarPenyedia.nameRoute);
                                        _formKey.currentState!.validate();
                                        _login();
                                      },
                                child: Text(
                                  _isLoading ? 'Loging...' : 'Login',
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
                                'Tidak punya akun ? ',
                                textAlign: TextAlign.start,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DaftarPenyedia()),
                                  );
                                },
                                child: Text(
                                  'Daftar',
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
      ),
    );
  }

  _login() async {
    _formKey.currentState!.validate();
    setState(() {
      _isLoading = true;
    });

    var data = {'email': email.text, 'password': password.text};

    var res = await Network().auth(data, '/login/penyedia');
    var body = jsonDecode(res.body);

    if (body['errors'] != null) {
      if (body['errors']['email'] != null) {
        _showMsg(body['errors']['email'][0].toString());
        setState(() {
          validatorEmail = false;
          errorEmail = body['errors']['email'][0].toString();
        });
      } else if (body['errors']['password'] != null) {
        _showMsg(body['errors']['password'][0].toString());
        setState(() {
          validatorEmail = true;
        });
      } else {
        setState(() {
          validatorEmail = true;
        });
      }
      setState(() {
        _isLoading = false;
      });
      return null;
    } else {
      setState(() {
        validatorEmail = true;
      });
    }

    if (body['success']) {
      validatorEmail = true;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      print(body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashPage(),
        ),
      );
      _showMsg('Login successfully!');
      setState(() {
        _isLoading = false;
      });
    } else {
      _showMsg('Login not successfully!');
      setState(() {
        _isLoading = false;
      });
    }
  }
}
