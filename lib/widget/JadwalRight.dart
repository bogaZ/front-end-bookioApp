import 'package:flutter/material.dart';
import '../models/jadwal.dart';

class jadwal2 extends StatelessWidget {
  Iterable<Jadwal> data;
  jadwal2({required this.data});
  @override
  Widget build(BuildContext context) {
    // OBJEK //! HARI UNTUK MENGAMBIL DATA BERDASARKAN HARI
    final jumat = data.where((element) => element.hari == "Friday").toList();
    final sabtu = data.where((element) => element.hari == "Saturday").toList();
    final minggu = data.where((element) => element.hari == "Sunday").toList();
    return Row(
      children: [
        Container(
          //color: Colors.blue,
          width: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Jum'at"), Text("Sabtu"), Text("Minggu")],
          ),
        ),
        Container(
          //color: Colors.yellow,
          //width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              jumat.first.status != false
                  ? Text(jumat.first.jamBuka + "-" + jumat.first.jamTutup)
                  : Text(
                      "Tutup",
                      style: TextStyle(color: Colors.red),
                    ),
              sabtu.first.status != false
                  ? Text(sabtu.first.jamBuka + "-" + sabtu.first.jamTutup)
                  : Text(
                      "Tutup",
                      style: TextStyle(color: Colors.red),
                    ),
              minggu.first.status != false
                  ? Text(minggu.first.jamBuka + "-" + minggu.first.jamTutup)
                  : Text(
                      "Tutup",
                      style: TextStyle(color: Colors.red),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
