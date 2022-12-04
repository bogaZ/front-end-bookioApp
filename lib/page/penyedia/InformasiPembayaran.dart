import 'package:bookio2/page/penyedia/KelolaStudio.dart';
import 'package:bookio2/page/penyedia/ProfilePenyedia.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformasiPembayaran extends StatefulWidget {
  static const routeName = "/informasiPembayaran";
  InformasiPembayaran({Key? key}) : super(key: key);

  @override
  State<InformasiPembayaran> createState() => _InformasiPembayaranState();
}

class _InformasiPembayaranState extends State<InformasiPembayaran> {
  final nomorRekening = TextEditingController();
  final namaBank = TextEditingController();
  final namaPemilik = TextEditingController();
  PesanKonfirmasi(BuildContext context, var data) {
    Widget okButton = Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          onPressed: () {
            UserProvider().updateRekening(data, context);
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

    nomorRekening.text = userProvider.rekening['nomer_rekening'];
    namaBank.text = userProvider.rekening['nama_bank'];
    namaPemilik.text = userProvider.rekening['nama_pemilik'];
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
                      Text("Nomer Rekening"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nomorRekening,
                        keyboardType: TextInputType.emailAddress,
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
                    // dataRekening.updateDataRekening(
                    //     nomorRekening.text, namaBank.text, namaPemilik.text);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             BottomNavbarPenyedia(argument: 2)));
                    var data = {
                      'nama_bank': namaBank.text,
                      'nomer_rekening': nomorRekening.text,
                      'nama_pemilik': namaPemilik.text,
                    };
                    PesanKonfirmasi(context, data);
                  },
                  child: Text("Update"),
                ),
              )
            ],
          ),
        ));
  }
}
