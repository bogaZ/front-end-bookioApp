import 'dart:convert';

import 'package:bookio2/alert/BookingDiterima.dart';
import 'package:bookio2/alert/BookingGagal.dart';
import 'package:bookio2/models/RuangDipesan.dart';
import 'package:bookio2/page/Pembayaran.dart';
import 'package:bookio2/page/PilihJadwal.dart';
import 'package:bookio2/page/penyedia/PemesananLangsung.dart';
import 'package:bookio2/widget/button_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class PilihJadwalServices with ChangeNotifier {
  // DATA //! RUANG YANG DIPESAN SESUAI DENGAN ID PEMESANAN
  final List<RuangDipesan> _dataRuangDipesan = [
    // RuangDipesan(
    //     idRuangDipesan: "2",
    //     idPemesanan: "1",
    //     idStudio: "0",
    //     idRuang: "3",
    //     namaStudio: "Studio 2",
    //     namaRuang: "Ruang 1",
    //     jamAwal: "21:00",
    //     jamAkhir: "23:00",
    //     totalDurasi: 2,
    //     totalPembayaran: 70000,
    //     tanggal: "2022-06-30"),
  ];
  List<RuangDipesan> get dataRuangDipesan => _dataRuangDipesan;

  // sudahDipesan(int index) {
  //   final data = dataRuangDipesan
  //       .where((element) =>
  //           element.idRuang == ambilIdRuang() &&
  //           element.tanggal == tanggalDipilih.toString().substring(0, 10))
  //       .toList();
  //   if (data.isNotEmpty) {
  //     final mydata = data.where((element) =>
  //         index >=
  //             dataJam.indexWhere(
  //                 (element2) => element2.namaJam == element.jamAwal) &&
  //         index <
  //             dataJam.indexWhere(
  //                 (element2) => element2.namaJam == element.jamAkhir));
  //     if (mydata.isNotEmpty) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  // }

  getDataPemesanan(var data, var studio_id) async {
    var res = await Network().postData(data, '/pemesanan/studio/${studio_id}');
    Map<String, dynamic> body = jsonDecode(res.body);
    // String key = body['data'].keys.toList()[0];
    // print(jsonDecode(body['data'][key]['fasilitas_dipesan'])[0]
    //     ['nama_fasilitas']);
    _dataRuangDipesan.clear();

    var myKey = body['data'].length;
    print(myKey);
    if (myKey > 1) {
      for (int i = 0; i < body['data'].keys.toList().length; i++) {
        String key = body['data'].keys.toList()[i];
        for (int j = 0;
            j < jsonDecode(body['data'][key]['fasilitas_dipesan']).length;
            j++) {
          _dataRuangDipesan.add(RuangDipesan(
              idRuang: jsonDecode(body['data'][key]['fasilitas_dipesan'])[j]
                  ['fasilitas_id'],
              namaRuang: jsonDecode(body['data'][key]['fasilitas_dipesan'])[j]
                  ['nama_fasilitas'],
              jamAwal: jsonDecode(body['data'][key]['fasilitas_dipesan'])[j]
                  ['jam_awal'],
              jamAkhir: jsonDecode(body['data'][key]['fasilitas_dipesan'])[j]
                  ['jam_akhir'],
              totalDurasi: jsonDecode(body['data'][key]['fasilitas_dipesan'])[j]
                  ['durasi'],
              totalPembayaran:
                  jsonDecode(body['data'][key]['fasilitas_dipesan'])[j]
                      ['total'],
              tanggal: body['data'][key]['tanggal'],
              status: body['data'][key]['status'],
              dedline: DateTime.parse(body['data'][key]['dedline'])));
        }
      }
    } else {
      print('Kosong');
      for (int i = 0; i < body['data'].length; i++) {
        for (int j = 0;
            j < jsonDecode(body['data'][i]['fasilitas_dipesan']).length;
            j++) {
          _dataRuangDipesan.add(RuangDipesan(
              idRuang: jsonDecode(body['data'][i]['fasilitas_dipesan'])[j]
                  ['fasilitas_id'],
              namaRuang: jsonDecode(body['data'][i]['fasilitas_dipesan'])[j]
                  ['nama_fasilitas'],
              jamAwal: jsonDecode(body['data'][i]['fasilitas_dipesan'])[j]
                  ['jam_awal'],
              jamAkhir: jsonDecode(body['data'][i]['fasilitas_dipesan'])[j]
                  ['jam_akhir'],
              totalDurasi: jsonDecode(body['data'][i]['fasilitas_dipesan'])[j]
                  ['durasi'],
              totalPembayaran:
                  jsonDecode(body['data'][i]['fasilitas_dipesan'])[j]['total'],
              tanggal: body['data'][i]['tanggal'],
              status: body['data'][i]['status'],
              dedline: DateTime.parse(body['data'][i]['dedline'])));
        }
      }
    }

    print(_dataRuangDipesan);
  }

  // COUNTER //! COUNTER
  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  addPemesanan(var data, BuildContext context) async {
    var res = await Network().postData(data, '/pemesanan/penyewa/add');
    var body = jsonDecode(res.body);
    print(body);
    if (body['success']) {
      Navigator.pushNamed(context, Pembayaran.routeName,
          arguments: body['data']);

      BookingDiterima(context: context).bookingDiterima();
    } else {
      Navigator.pushNamed(context, BottomNavbar.nameRoute, arguments: 0);

      BookingGagal(context: context).bookingGagal();
    }
  }

  addPemesananPenyedia(var data, BuildContext context) async {
    var res = await Network().postData(data, '/pemesanan/penyedia/add');
    var body = jsonDecode(res.body);
    print(body);
    if (body['success']) {
      Navigator.pushNamed(context, PemesananLangsung.routeName);

      // BookingDiterima(context: context).bookingDiterima();
    }
  }

  Map<String, dynamic> _dataPemesanan = {};
  Map<String, dynamic> get dataPemesanan => _dataPemesanan;
  set dataPemesanan(Map<String, dynamic> value) {
    _dataPemesanan = value;
    notifyListeners();
  }

  Map<String, dynamic> _dataPembayaran = {};
  Map<String, dynamic> get dataPembayaran => _dataPembayaran;
  set dataPembayaran(Map<String, dynamic> value) {
    _dataPembayaran = value;
    notifyListeners();
  }

  getDetailPembayaran(var invoice) async {
    var data = {'invoice': invoice};
    var res = await Network().postData(data, '/pemesanan/penyewa/show/detail');
    var body = jsonDecode(res.body);
    _dataPemesanan = body['data'];
    _dataPembayaran = body['data_bank'];
  }
}
