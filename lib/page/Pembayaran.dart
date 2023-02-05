import 'package:bookio2/provider/ImageServices.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/services/PilihJadwalServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../widget/button_navbar.dart';
import '../widget/timer.dart';
import 'dart:io';

class Pembayaran extends StatefulWidget {
  static const routeName = "/pembayaran";
  Pembayaran({Key? key}) : super(key: key);

  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  @override
  Widget build(BuildContext context) {
    final invoice = ModalRoute.of(context)!.settings.arguments as String;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PilihJadwalServices()),
        ChangeNotifierProvider(create: (context) => StudioProvider()),
        ChangeNotifierProvider(create: (context) => ImageServices())
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, BottomNavbar.nameRoute);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text('Pembayaran'),
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, BottomNavbar.nameRoute);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: Consumer<PilihJadwalServices>(
              builder: (context, pilihJadwalServices, _) {
            return FutureBuilder(
                future: pilihJadwalServices.getDetailPembayaran(invoice),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                //border: Border.all(width: 1, color: Colors.black38),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        "assets/images/Profil.png",
                                        width: 200,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Kode transaksi : ',
                                              style: TextStyle(
                                                  color: Colors.black38),
                                            ),
                                            Text(
                                              pilihJadwalServices
                                                  .dataPemesanan['invoice'],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Tanggal Transaksi : ',
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                    Text(
                                      DateTime.parse(pilihJadwalServices
                                              .dataPemesanan['created_at'])
                                          .toString()
                                          .substring(
                                              0,
                                              pilihJadwalServices.dataPemesanan[
                                                          'created_at']
                                                      .toString()
                                                      .length -
                                                  11),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Total Pembayaran : ',
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(pilihJadwalServices
                                              .dataPemesanan['total_tarif']),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 2,
                                      color: Colors.black38,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Cara Pembayaran'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 300,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepOrange,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Batas Waktu Pembayaran pukul : ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          DateFormat.Hm()
                                              .format(DateTime.parse(
                                                  pilihJadwalServices
                                                          .dataPemesanan[
                                                      'dedline']))
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )
                                    // TimerBookio(),
                                    // Icon(Icons.timer, size: 18, color: Colors.white)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // PEMBAYARAN //!UPLOAD BUKTI PEMBAYARAN
                            Container(
                              width: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),

                              // NOMER //!REKENING TRANSFER
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Transfer bank BNI",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Image.asset(
                                              "assets/images/bni.png",
                                              width: 70,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Silakan lakukan transfer sesuai nominal yang diberikan pada nomor rekening berikut & upload bukti pembayaran yang telah dilakukan',
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.black12, width: 1)),
                                      color: Color.fromARGB(31, 201, 201, 201),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nama Bank",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(pilihJadwalServices
                                                  .dataPembayaran['nama_bank']),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  31, 175, 175, 175),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black26,
                                                  width: 2),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Nomor Rekening",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  31, 175, 175, 175),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black26,
                                                  width: 2),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      pilihJadwalServices
                                                              .dataPembayaran[
                                                          'nomer_rekening']),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 20, 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Clipboard.setData(ClipboardData(
                                                          text: pilihJadwalServices
                                                                  .dataPembayaran[
                                                              'nomer_rekening']));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text("Copy"),
                                                        Icon(Icons.edit,
                                                            size: 18,
                                                            color:
                                                                Colors.black54)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Nama Pemilik",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  31, 175, 175, 175),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black26,
                                                  width: 2),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(pilihJadwalServices
                                                      .dataPembayaran[
                                                  'nama_pemilik']),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Jumlah Transfer",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  31, 175, 175, 175),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black26,
                                                  width: 2),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(pilihJadwalServices
                                                          .dataPemesanan[
                                                      'total_tarif'])),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Consumer<ImageServices>(
                                                builder: (context,
                                                    imageServices, _) {
                                              return Column(
                                                children: [
                                                  imageServices.data
                                                      ? Container(
                                                          child: Column(
                                                            children: [
                                                              Image.file(
                                                                imageServices
                                                                    .image,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(),
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.deepOrange,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50))),
                                                      onPressed: () {
                                                        imageServices
                                                            .getImage();

                                                        // print(data);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "Upload Bukti Pembayaran "),
                                                            Icon(
                                                              Icons.upload,
                                                              size: 18,
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              );
                                            }),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Consumer<ImageServices>(builder:
                                              (context, imageServices, _) {
                                            return Container(
                                              key: UniqueKey(),
                                              child: !imageServices.data
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                primary: Colors
                                                                    .green,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50))),
                                                            onPressed: () {
                                                              Map<String,
                                                                      String>
                                                                  data = {
                                                                'pemesanan_id':
                                                                    pilihJadwalServices
                                                                        .dataPemesanan[
                                                                            'id']
                                                                        .toString(),
                                                              };

                                                              imageServices
                                                                  .uploadBuktiPembayaran(
                                                                      data,
                                                                      imageServices
                                                                          .image
                                                                          .path,
                                                                      context);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "Kirim Bukti Pembayaran "),
                                                                  Icon(
                                                                    Icons
                                                                        .send_rounded,
                                                                    size: 18,
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                            );
                                          }),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepOrange,
                                                    width: 2)),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BottomNavbar(
                                                              argument: 0,
                                                            )));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Back",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.deepOrange),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
