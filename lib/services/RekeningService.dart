import 'dart:convert';

import 'package:bookio2/models/Rekening.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/widgets.dart';

class RekeningService with ChangeNotifier {
  // MELAKUKAN REQUEST UNTUK MENDAPATKAN DATA AKUN PEMBAYARAN PENYEDIA TEMPAT STUDIO
  getDataRekening() async {
    var res = await Network().getData('/pembayaran/penyedia');
    var body = jsonDecode(res.body);
    if (body['success']) {
      _dataRekening = [
        Rekening(
            nomorRekening: body['data']['nomer_rekening'],
            namaBank: body['data']['nama_bank'],
            namaPemilik: body['data']['nama_pemilik'],
            jumlahSaldo: body['saldo'])
      ];
      print(body);
    }
  }

  List<Rekening> _dataRekening = [];
  List<Rekening> get dataRekening => _dataRekening;
  set dataRekening(List<Rekening> value) {
    _dataRekening = value;
    notifyListeners();
  }

  updateDataRekening(
      String nomorRekening, String namaBank, String namaPemilik) {
    dataRekening.first.nomorRekening = nomorRekening;
    dataRekening.first.namaBank = namaBank;
    dataRekening.first.namaPemilik = namaPemilik;
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
