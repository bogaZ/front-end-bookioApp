import 'dart:convert';

import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/widgets.dart';

class JadwalServices with ChangeNotifier {
  // jadwal
  List<Jadwal> _jadwalPenyedia = [];
  List<Jadwal> get jadwalPenyedia => _jadwalPenyedia;
  set jadwalPenyedia(List<Jadwal> value) {
    _jadwalPenyedia = value;
    notifyListeners();
  }

  getJadwal() async {
    var res = await Network().getData('/jadwal/show');
    var body = jsonDecode(res.body);

    _jadwalPenyedia = List.generate(
        body.length,
        (index) => Jadwal(
            body[index]['id'],
            body[index]['studio_id'],
            body[index]['nama_hari'],
            body[index]['jam_buka'],
            body[index]['jam_tutup'],
            body[index]['status'] == 0 ? false : true));
    print(body);
  }

  aktifJadwal(var data, var id) async {
    var res = await Network().putData(data, '/jadwal/edit/${id}');
    var body = jsonDecode(res.body);
    print(body);
  }

  updateJadwal(var data, var id) async {
    var res = await Network().putData(data, '/jadwal/edit/${id}');
    var body = jsonDecode(res.body);
    print(body);
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
