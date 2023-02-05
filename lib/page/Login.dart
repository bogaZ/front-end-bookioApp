import 'dart:convert';
import 'dart:io';
import 'package:bookio2/page/SplashScreen.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Daftar.dart';
// import '../widget/button_navbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPenyewa extends StatefulWidget {
  const LoginPenyewa({Key? key}) : super(key: key);

  @override
  _LoginPenyewaState createState() => _LoginPenyewaState();
}

class _LoginPenyewaState extends State<LoginPenyewa> {
  //final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final email = TextEditingController();
  final password = TextEditingController();

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        //key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
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
                          Image.asset(
                            'assets/images/Profil.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Text(
                              'Email',
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
                                        _formKey.currentState!.validate();
                                        _login('/login/penyewa');
                                      },
                                child: Text(
                                  _isLoading ? 'Loging...' : 'login',
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
                                        builder: (context) =>
                                            const DaftarPenyewa()),
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

  _login(String link) async {
    setState(() {
      _isLoading = true;
    });

    var data = {'email': email.text, 'password': password.text};

    var res = await Network().auth(data, link);
    var body = jsonDecode(res.body);

    if (body['errors'] != null) {
      if (body['errors']['email'] != null) {
        _showMsg(body['errors']['email'][0].toString());
      } else if (body['errors']['password'] != null) {
        _showMsg(body['errors']['password'][0].toString());
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
