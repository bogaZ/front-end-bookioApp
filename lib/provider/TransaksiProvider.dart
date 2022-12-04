import 'dart:convert';

import 'package:bookio2/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookio2/models/TransaksiModels.dart';

class TransaksiProvider with ChangeNotifier {
  List<TransaksiModels> _dataTransaksi = [];
  List<TransaksiModels> get dataTransaksi => _dataTransaksi;
  set dataTransaksi(List<TransaksiModels> value) {
    _dataTransaksi = value;
    notifyListeners();
  }

  getTransaksi() async {
    var res = await Network().getData('/transaksi/penyedia');
    var body = jsonDecode(res.body);
    print(body);
    if (body['data'].length > 1) {
      _dataTransaksi.clear();
      for (int i = body['data'].length - 1; i >= 0; i--) {
        String key = body['data'].keys.toList()[i].toString();

        _dataTransaksi.add(TransaksiModels(
            id: body['data'][key]['id'],
            invoice: body['data'][key]['invoice'],
            namaPenyewa: body['data'][key]['nama_penyewa'],
            namaStudio: body['data'][key]['nama_studio'],
            tanggal: DateTime.parse(body['data'][key]['created_at']),
            jenis: body['data'][key]['jenis'],
            totalPembayaran: body['data'][key]['total'],
            totalBiayaAdmin: body['data'][key]['biaya_admin'],
            totalPemasukan:
                body['data'][key]['total'] - body['data'][key]['biaya_admin']));
        print(dataTransaksi.first.tanggal);
      }
    } else {
      _dataTransaksi.clear();
      for (int i = 0; i < body['data'].length; i++) {
        _dataTransaksi.add(TransaksiModels(
            id: body['data'][i]['id'],
            invoice: body['data'][i]['invoice'],
            namaPenyewa: body['data'][i]['nama_penyewa'],
            namaStudio: body['data'][i]['nama_studio'],
            tanggal: DateTime.parse(body['data'][i]['created_at']),
            jenis: body['data'][i]['jenis'],
            totalPembayaran: body['data'][i]['total'],
            totalBiayaAdmin: body['data'][i]['biaya_admin'],
            totalPemasukan:
                body['data'][i]['total'] - body['data'][i]['biaya_admin']));
        print(dataTransaksi.first.tanggal);
      }
    }
  }
}
