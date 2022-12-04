import 'package:bookio2/provider/UserProvider.dart';
import 'package:flutter/material.dart';

class UbahPassword extends StatefulWidget {
  static const routeName = "/ubahPassword";
  UbahPassword({Key? key}) : super(key: key);

  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final old_password = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  PesanKonfirmasi(BuildContext context, var data) {
    Widget okButton = Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          onPressed: () {
            UserProvider().updatePassword(data, context, 'penyewa');
          },
          child: Text('Simpan')),
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
      content: Text("Simpan perubahan..?"),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Ubah Password'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: old_password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tidak boleh dikosongkan!';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
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
                            hintText: 'Masukkan Password Lama',
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tidak boleh dikosongkan!';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          //autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Masukkan Password Baru',
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordConfirmation,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tidak boleh dikosongkan!';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          //autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
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
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var data = {
                              'old_password': old_password.text,
                              'password': password.text,
                              'password_confirmation':
                                  passwordConfirmation.text,
                            };
                            PesanKonfirmasi(context, data);
                          }
                        },
                        child: Text('Simpan')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
