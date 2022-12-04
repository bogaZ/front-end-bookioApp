import 'package:bookio2/page/penyedia/ProfilePenyedia.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';

class InformasiPribadiPenyedia extends StatefulWidget {
  static const routeName = "/informasiProbadiPenyedia";
  InformasiPribadiPenyedia({Key? key}) : super(key: key);

  @override
  _InformasiPribadiPenyediaState createState() =>
      _InformasiPribadiPenyediaState();
}

class _InformasiPribadiPenyediaState extends State<InformasiPribadiPenyedia> {
  final namaLengkap = TextEditingController();
  final email = TextEditingController();
  final nomorHp = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PesanKonfirmasi(BuildContext context, var data, UserProvider userProvider) {
    Widget okButton = Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          onPressed: () {
            userProvider.updateUser(data, "penyedia", context);
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
    final userProvider =
        ModalRoute.of(context)!.settings.arguments as UserProvider;
    namaLengkap.text = userProvider.userData['name'];
    email.text = userProvider.userData['email'];
    nomorHp.text = userProvider.userData['nomor_hp'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavbarPenyedia(
                            argument: 2,
                          )));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.deepOrange,
        title: Text('Informasi Pribadi'),
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(50),
                          //     color: Colors.black12,
                          //   ),
                          // ),
                          // TextButton(
                          //     onPressed: null,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Icon(
                          //           Icons.mode_edit_sharp,
                          //           color: Colors.green,
                          //         ),
                          //         Text(
                          //           'Ubah Foto Profil',
                          //           style: TextStyle(color: Colors.green),
                          //         ),
                          //       ],
                          //     )),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Container(
                          //   height: 3,
                          //   width: double.infinity,
                          //   color: Colors.black12,
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          // TextFormField(
                          //   keyboardType: TextInputType.emailAddress,
                          //   //autofocus: true,
                          //   obscureText: false,
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(
                          //       Icons.person_outline,
                          //       color: Colors.grey,
                          //     ),
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     hintText: 'Masukkan Username',
                          //     hintStyle: TextStyle(
                          //       color: Colors.black12,
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.black12,
                          //         width: 1,
                          //       ),
                          //       borderRadius: BorderRadius.circular(5),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.black12,
                          //         width: 1,
                          //       ),
                          //       borderRadius: BorderRadius.circular(5),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          TextFormField(
                            controller: namaLengkap,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama tidak boleh kosong!';
                              } else {
                                return null;
                              }
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong!';
                              } else {
                                return null;
                              }
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: nomorHp,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nomer Hp tidak boleh kosong!';
                              } else {
                                return null;
                              }
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
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
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
                                "email": email.text,
                                "name": namaLengkap.text,
                                "nomor_hp": nomorHp.text
                              };
                              PesanKonfirmasi(context, data, userProvider);
                            }
                          },
                          child: Text('Simpan'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
