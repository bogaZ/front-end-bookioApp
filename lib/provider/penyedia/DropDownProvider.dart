import 'package:flutter/material.dart';

class DropDownProvider with ChangeNotifier {
  DropDownProvider() {
    myJamAwal = jamAwal;
    myJamAkhir = jamAkhir;
  }
  List<String> _jamAwal = List.generate(
      24,
      (index) => index < 10
          ? "0" + index.toString() + ":00"
          : (index).toString() + ":00");
  List<String> get jamAwal => _jamAwal;

  List<String> _jamAkhir = List.generate(
      24,
      (index) => index < 9
          ? "0" + (index + 1).toString() + ":00"
          : (index + 1).toString() + ":00");
  List<String> get jamAkhir => _jamAkhir;

  List<String> _myJamAwal = [];
  List<String> get myJamAwal => _myJamAwal;
  set myJamAwal(List<String> value) {
    _myJamAwal = value;
    notifyListeners();
  }

  List<String> _myJamAkhir = [];
  List<String> get myJamAkhir => _myJamAkhir;
  set myJamAkhir(List<String> value) {
    _myJamAkhir = value;
    notifyListeners();
  }

  cekJamAwal(String data) {
    int index = jamAwal.indexOf(data);
    List<String> dataku = jamAkhir.getRange(index, 24).toList();
    myJamAkhir = dataku;
  }

  cekJamAkhir(String data) {
    int index = jamAkhir.indexOf(data);
    List<String> dataku = jamAwal.getRange(0, index + 1).toList();
    myJamAwal = dataku;
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
