import 'dart:convert';

import 'package:bookio2/models/Rekening.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/widgets.dart';

class RekeningProvider with ChangeNotifier {
  List<Rekening> _dataRekening = [];
  List<Rekening> get dataRekening => _dataRekening;
  set dataRekening(List<Rekening> value) {
    _dataRekening = value;
    notifyListeners();
  }

  // Menampung tolta saldo penyedia tempat studio musik
  int _tampungSaldo = 0;
  int get tampungSaldo => _tampungSaldo;
  set tampungSaldo(int value) {
    _tampungSaldo = value;
    notifyListeners();
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  getDataRekening(var data) {
    _dataRekening = data;
    _tampungSaldo = _dataRekening.first.jumlahSaldo;
    print(_dataRekening.first.jumlahSaldo);
  }
}
