import 'dart:convert';

import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/widgets.dart';

class JadwalProvider with ChangeNotifier {
  JadwalProvider() {
    datajadwalnya();
  }

  List<Jadwal> _mydataJadwal = [];
  List<Jadwal> get mydataJadwal => _mydataJadwal;
  set mydataJadwal(List<Jadwal> value) {
    _mydataJadwal = value;
    notifyListeners();
  }

  // jadwal
  List<Jadwal> _jadwalPenyedia = [];
  List<Jadwal> get jadwalPenyedia => _jadwalPenyedia;
  set jadwalPenyedia(List<Jadwal> value) {
    _jadwalPenyedia = value;
    notifyListeners();
  }

  getDataJadwal(var data) {
    _jadwalPenyedia = data;
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  List<Jadwal> _dataJadwal = [];
  List<Jadwal> get dataJadwal => _dataJadwal;
  set dataJadwal(List<Jadwal> value) {
    _dataJadwal = value;
    notifyListeners();
  }

  // MENGAMBIL DATA BERDASARKAN //! ID STUDIO
  datajadwalnya() {
    _dataJadwal =
        _mydataJadwal.where((element) => element.idStudio == "1").toList();
  }

  bool _select = false;
  bool get select => _select;
  set select(bool value) {
    _select = value;
    notifyListeners();
  }

  List<String> _tampungJamAwal = [];
  List<String> get tampungJamAwal => _tampungJamAwal;
  set tampungJamAwal(List<String> value) {
    _tampungJamAwal = value;
    notifyListeners();
  }

  List<String> _tampungJamAkhir = [];
  List<String> get tampungJamAkhir => _tampungJamAkhir;
  set tampungJamAkhir(List<String> value) {
    _tampungJamAkhir = value;
    notifyListeners();
  }

  updateJadwal(int index) {
    jadwalPenyedia[index].status = !jadwalPenyedia[index].status;
  }
}
