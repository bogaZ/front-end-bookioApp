// import 'dart:ui';
// import 'package:bookio2/page/BeriUlasan.dart';
// import 'package:bookio2/page/DetailPemesanan.dart';
import 'package:flutter/material.dart';

class ListNotifikasi extends StatelessWidget {
  //ListNotifikasi({Key? key}) : super(key: key);

  String tanggal;
  String Judul;
  String Deskripsi;
  String link;

  ListNotifikasi({
    required this.Deskripsi,
    required this.Judul,
    required this.tanggal,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, link);
      },
      child: Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(width: 2, color: Colors.black26))),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    tanggal,
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    width: 5,
                    height: 5,
                  )
                ],
              ),
              Text(
                Judul,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(Deskripsi)
            ],
          ),
        ),
      ),
    );
  }
}
