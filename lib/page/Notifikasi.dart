import 'package:flutter/material.dart';
import '../widget/list_notifikasi.dart';

class Notifikasi extends StatefulWidget {
  static const routeName = "/notifikasi";
  Notifikasi({Key? key}) : super(key: key);

  @override
  _NotifikasiState createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  List<Widget> listNotif = [];

  _NotifikasiState() {
    // for (int i = 1; i <= 100; i+=1) {
    // }
    listNotif.add(ListNotifikasi(
      tanggal: '2022-02-02 18:10:00',
      Judul: 'Booking expired L2R6786jundhkjh',
      Deskripsi: 'Booking anda telah kadaluarsa',
      link: "kosong",
    ));
    listNotif.add(ListNotifikasi(
      tanggal: '2022-02-02 18:10:00',
      Judul: 'Booking Omexo Studio',
      Deskripsi: 'Booking diterima segera lakukan pembayaran',
      link: "kosong",
    ));
    listNotif.add(ListNotifikasi(
      tanggal: '2022-02-02 18:10:00',
      Judul: 'Booking succes L2R6786jundhkjh',
      Deskripsi: 'Booking berhasil pembayaran telah diterima',
      link: "kosong",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Notifikasi'),
      ),
      body: Center(
        child: Container(
          width: 600,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: ListView(children: listNotif),
          ),
        ),
      ),
    );
  }
}
