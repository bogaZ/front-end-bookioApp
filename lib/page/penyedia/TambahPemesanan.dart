import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/services/PilihJadwalServices.dart';
import 'package:bookio2/widget/grid_jam.dart';
import 'package:bookio2/widget/grid_ruang.dart';
import 'package:bookio2/widget/kalender.dart';
import 'package:bookio2/widget/penyedia/ModalsPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TambahPemesanan extends StatelessWidget {
  static const routeName = "/tambahPemesanan";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    StudioProvider studioProvider =
        ModalRoute.of(context)!.settings.arguments as StudioProvider;
    final idStudio = studioProvider.detailStudio.id;
    final namaUser = TextEditingController();
    final nomerHp = TextEditingController();
    print(studioProvider.dataRuang);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudioProvider()),
        ChangeNotifierProvider(create: (context) => PilihJadwalServices()),
        ChangeNotifierProvider(
            create: (context) => PilihJadwalProvider(
                idStudio: idStudio,
                context: context,
                studioProvider: studioProvider))
      ],
      child: GestureDetector(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text("Tambah Pemesanan"),
            ),
            body: Scrollbar(
              thumbVisibility: true,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pilih Tanggal",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                            Container(
                                child: KalenderBookio(idStudio: idStudio)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Pilih Tempat",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PemilihanTempat(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Pilih Jam",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PemilihanJam(),
                            Text(
                              "Identitas",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Text(
                                'Nama Pemesan',
                                style: TextStyle(),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: namaUser,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama pemesan harus diisi!';
                                  }
                                  return null;
                                },
                                //autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan nama pemesan',
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
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Text(
                                'Nomor HP',
                                style: TextStyle(),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: nomerHp,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nomor hp harus diisi!';
                                  }
                                  return null;
                                },
                                //autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_android_rounded,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Masukkan nomer handphone',
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
                        ),
                      ),
                    )),
                    Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: Consumer<PilihJadwalProvider>(
                              builder: (context, pilihJadwalProvider, _) =>
                                  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrange,
                                ),
                                onPressed: pilihJadwalProvider.totalDuration ==
                                        0
                                    ? null
                                    : () {
                                        // pilihJadwalProvider.namaUser =
                                        //     namaUser.text;
                                        // pilihJadwalProvider.nomerHp =
                                        //     nomerHp.text;
                                        FocusScope.of(context).unfocus();
                                        var data = {
                                          'nama': namaUser.text,
                                          'nomer_hp': nomerHp.text
                                        };

                                        if (_formKey.currentState!.validate()) {
                                          ModalsPopupPenyedia(
                                                  idStudio: idStudio.toString(),
                                                  identitas: data,
                                                  context: context,
                                                  data: pilihJadwalProvider)
                                              .onButton();
                                        }
                                        // Close the dialog programmatically
                                      },
                                child: Text("Simpan"),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
