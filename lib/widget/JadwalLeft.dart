import 'package:flutter/material.dart';
import '../models/jadwal.dart';

class Jadwal1 extends StatelessWidget {
  Iterable<Jadwal> data;
  Jadwal1({required this.data});

  @override
  Widget build(BuildContext context) {
    // OBJEK //! HARI UNTUK MENGAMBIL DATA BERDASARKAN HARI
    final senin = data.where((element) => element.hari == "Monday").toList();
    final selasa = data.where((element) => element.hari == "Tuesday").toList();
    final rabu = data.where((element) => element.hari == "Wednesday").toList();
    final kamis = data.where((element) => element.hari == "Thursday").toList();
    return Row(
      children: [
        Container(
          //color: Colors.yellow,
          width: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Senin'),
              Text('Selasa'),
              Text('Rabu'),
              Text('Kamis'),
            ],
          ),
        ),
        Container(
          //color: Colors.yellow,
          //width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              senin.first.status != false
                  ? Text(senin.first.jamBuka + "-" + senin.first.jamTutup)
                  : Text(
                      "Tutup",
                      style: TextStyle(color: Colors.red),
                    ),
              selasa.first.status != false
                  ? Text(selasa.first.jamBuka + "-" + selasa.first.jamTutup)
                  : Text(
                      "Tutup",
                      style: TextStyle(color: Colors.red),
                    ),
              rabu.first.status != false
                  ? Text(rabu.first.jamBuka + "-" + rabu.first.jamTutup)
                  : Text(
                      "Tutup",
                      style: TextStyle(color: Colors.red),
                    ),
              kamis.first.status != false
                  ? Text(kamis.first.jamBuka + "-" + kamis.first.jamTutup)
                  : Text("Tutup", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
