import 'package:flutter/material.dart';
import '../models/jadwal.dart';

@immutable
class Jadwal2 extends StatelessWidget {
  final Iterable<Jadwal> data;
  const Jadwal2({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    // OBJEK //! HARI UNTUK MENGAMBIL DATA BERDASARKAN HARI
    final jumat = data.where((element) => element.hari == "Friday").toList();
    final sabtu = data.where((element) => element.hari == "Saturday").toList();
    final minggu = data.where((element) => element.hari == "Sunday").toList();
    return Row(
      children: [
        SizedBox(
          //color: Colors.blue,
          width: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [Text("Jum'at"), Text("Sabtu"), Text("Minggu")],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            jumat.first.status != false
                ? Text("${jumat.first.jamBuka}-${jumat.first.jamTutup}")
                : const Text(
                    "Tutup",
                    style: TextStyle(color: Colors.red),
                  ),
            sabtu.first.status != false
                ? Text("${sabtu.first.jamBuka}-${sabtu.first.jamTutup}")
                : const Text(
                    "Tutup",
                    style: TextStyle(color: Colors.red),
                  ),
            minggu.first.status != false
                ? Text("${minggu.first.jamBuka}-${minggu.first.jamTutup}")
                : const Text(
                    "Tutup",
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
      ],
    );
  }
}
