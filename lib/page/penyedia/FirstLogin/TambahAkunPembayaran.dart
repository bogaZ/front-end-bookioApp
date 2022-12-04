import 'dart:convert';

import 'package:bookio2/page/SplashScreen.dart';
import 'package:bookio2/page/penyedia/KelolaStudio.dart';
import 'package:bookio2/page/penyedia/ProfilePenyedia.dart';
import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TambahAkunPembayaran extends StatefulWidget {
  static const routeName = "/informasiPembayaran";
  TambahAkunPembayaran({Key? key}) : super(key: key);

  @override
  State<TambahAkunPembayaran> createState() => _TambahAkunPembayaran();
}

class _TambahAkunPembayaran extends State<TambahAkunPembayaran> {
  final _formKey = GlobalKey<FormState>();
  final nomorRekening = TextEditingController();
  final namaBank = TextEditingController();
  final namaPemilik = TextEditingController();

  @override
  void initState() {
    //getAkunPembayaran();
    super.initState();
  }

  void getAkunPembayaran() async {
    var res = await Network().getData('/pembayaran/penyedia');
    var body = jsonDecode(res.body);

    if (body['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          automaticallyImplyLeading: false,
          title: Text("Informasi Pembayaran"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nomer Rekening"),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: nomorRekening,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nomer rekening harus diisi!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.wallet,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Nomor Rekening',
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
                                height: 20,
                              ),
                              Text("Nama Bank"),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: namaBank,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama Bank harus diisi!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                //autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_balance_outlined,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Nama Bank',
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
                                height: 20,
                              ),
                              Text("Nama Pemilik Rekening"),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: namaPemilik,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama pemilik harus diisi!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                //autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan Nama Pemilik',
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
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createAkunPemesanan();
                    }
                  },
                  child: Text("Simpan"),
                ),
              )
            ],
          ),
        ));
  }

  void createAkunPemesanan() async {
    var data = {
      'nomer_rekening': nomorRekening.text,
      'nama_bank': namaBank.text,
      'nama_pemilik': namaPemilik.text,
    };
    var res = await Network().postData(data, '/pembayaran/penyedia/add');
    var body = jsonDecode(res.body);
    if (body['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashPage(),
        ),
      );
    }
  }
}
