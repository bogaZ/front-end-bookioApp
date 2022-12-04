import 'package:bookio2/provider/NotifikasiProvider.dart';
import 'package:bookio2/widget/ListNotifikasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifikasiPenyedia extends StatelessWidget {
  static const routeName = "/notifikasiPenyedia";
  const NotifikasiPenyedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifikasi = Provider.of<NotifikasiProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Notifikasi"),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ListView(
            children: List.generate(
                dataNotifikasi.dataNotifikasi.length,
                (index) => ListNotifikasi(
                    Deskripsi: dataNotifikasi.dataNotifikasi[index].deskripsi,
                    Judul: dataNotifikasi.dataNotifikasi[index].judul,
                    tanggal: dataNotifikasi.dataNotifikasi[index].tanggal,
                    link: dataNotifikasi.dataNotifikasi[index].link)),
          ),
        ));
  }
}
