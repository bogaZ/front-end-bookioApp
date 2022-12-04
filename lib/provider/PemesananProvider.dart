import 'dart:convert';

import 'package:bookio2/models/Pemesanan.dart';
import 'package:bookio2/page/DetailPemesanan.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/widgets.dart';

class PemesananProvider with ChangeNotifier {
  // DATA //! PEMESANANA
  //? MENAMPUNG DATA PEMESANAN
  List<Pemesanan> _dataPemesanan = [
    // Pemesanan(
    //     idPemesanan: "0",
    //     kodeTransaksi: "bko22Jun20R1A22",
    //     idUser: "0",
    //     namaUser: "Budi Setiawanto",
    //     nomerHp: "089766755744",
    //     idStudio: "0",
    //     namaStudio: "Studio 1",
    //     tanggal: "2022-06-29",
    //     totalDurasi: 4,
    //     totalPembayaran: 200000,
    //     status: "Menunggu pemebayaran"),
  ];
  List<Pemesanan> get dataPemesanan => _dataPemesanan;
  set dataPemesanan(List<Pemesanan> value) {
    _dataPemesanan = value;
    notifyListeners();
  }

  getDataPemesanan() async {
    print('data Pemesanan');
    var res = await Network().getData('/pemesanan/penyewa/show');
    var body = jsonDecode(res.body);
    _dataPemesanan.clear();
    if (body['data'].length > 1) {
      print(body['data'].keys.toList());
      for (int i = 0; i < body['data'].keys.toList().length; i++) {
        String key = body['data'].keys.toList()[i];

        _dataPemesanan.add(Pemesanan(
            id: body['data'][key]['id'],
            invoice: body['data'][key]['invoice'],
            idUser: body['data'][key]['user_id'],
            namaUser: 'null',
            nomorHp: 'null',
            idStudio: body['data'][key]['studio_id'],
            namaStudio: 'null',
            alamatStudio: 'null',
            tanggal: DateTime.parse(body['data'][key]['tanggal']),
            totalPembayaran: body['data'][key]['total_tarif'],
            status: body['data'][key]['status'],
            dedline: DateTime.parse(body['data'][key]['dedline']),
            fasilitasDipesan:
                jsonDecode(body['data'][key]['fasilitas_dipesan'])));
        print('success');
      }
    } else {
      _dataPemesanan.clear();

      for (int i = 0; i < body['data'].length; i++) {
        _dataPemesanan.add(Pemesanan(
            id: body['data'][i]['id'],
            invoice: body['data'][i]['invoice'],
            idUser: body['data'][i]['user_id'],
            namaUser: 'null',
            nomorHp: 'null',
            idStudio: body['data'][i]['studio_id'],
            namaStudio: 'null',
            alamatStudio: 'null',
            tanggal: DateTime.parse(body['data'][i]['tanggal']),
            totalPembayaran: body['data'][i]['total_tarif'],
            status: body['data'][i]['status'],
            dedline: DateTime.parse(body['data'][i]['dedline']),
            fasilitasDipesan:
                jsonDecode(body['data'][i]['fasilitas_dipesan'])));
        print(body['data'][i]['invoice']);
      }
    }
    print(_dataPemesanan[3].invoice);
  }

  Pemesanan _detailPemesanan = Pemesanan(
      id: 0,
      invoice: "",
      idUser: 0,
      namaUser: 'null',
      nomorHp: 'null',
      idStudio: 0,
      namaStudio: 'null',
      alamatStudio: 'null',
      tanggal: DateTime.now(),
      totalPembayaran: 0,
      status: '',
      dedline: DateTime.now(),
      fasilitasDipesan: [{}]);

  Pemesanan get detailPemesanan => _detailPemesanan;
  set DetailPemesanan(Pemesanan value) {
    _detailPemesanan = value;
    notifyListeners();
  }

  getDetailPemesanan(var invoice) async {
    var data = {
      'invoice': invoice,
    };
    var res = await Network().postData(data, '/pemesanan/penyewa/show/detail');
    var body = jsonDecode(res.body);
    _detailPemesanan = Pemesanan(
        id: body['data']['id'],
        invoice: body['data']['invoice'],
        idUser: body['data']['user_id'],
        namaUser: 'null',
        nomorHp: 'null',
        idStudio: body['data']['studio_id'],
        namaStudio: 'null',
        alamatStudio: 'null',
        tanggal: DateTime.parse(body['data']['tanggal']),
        totalPembayaran: body['data']['total_tarif'],
        status: body['data']['status'],
        dedline: DateTime.parse(body['data']['dedline']),
        fasilitasDipesan: jsonDecode(body['data']['fasilitas_dipesan']));
    print(body);
  }

  getDetailPemesananPenyedia(int id) async {
    var res = await Network().getData('/pemesanan/penyedia/show/detail/${id}');
    var body = jsonDecode(res.body);
    print(body);
    _detailPemesanan = Pemesanan(
        id: body['id'],
        invoice: body['invoice'],
        idUser: body['user_id'],
        namaUser: body['name'],
        nomorHp: body['nomor_hp'],
        idStudio: body['studio_id'],
        namaStudio: body['nama_studio'],
        alamatStudio: body['alamat_studio'],
        tanggal: DateTime.parse(body['tanggal']),
        totalPembayaran: body['total'],
        status: body['status'],
        dedline: DateTime.parse(body['dedline']),
        fasilitasDipesan: body['fasilitas_dipesan']);
  }

  getDetailPemesananLangsung(int id) async {
    var res = await Network()
        .getData('/pemesanan/langsung/penyedia/show/detail/${id}');
    var body = jsonDecode(res.body);
    print(body);
    _detailPemesanan = Pemesanan(
        id: body['id'],
        invoice: body['invoice'],
        idUser: body['user_id'],
        namaUser: body['name'],
        nomorHp: body['nomor_hp'],
        idStudio: body['studio_id'],
        namaStudio: body['nama_studio'],
        alamatStudio: body['alamat_studio'],
        tanggal: DateTime.parse(body['tanggal']),
        totalPembayaran: body['total'],
        status: body['status'],
        dedline: DateTime.parse(body['dedline']),
        fasilitasDipesan: body['fasilitas_dipesan']);
  }

  getPemesananPenyedia() async {
    var res = await Network().getData('/pemesanan/penyedia/show');
    var body = jsonDecode(res.body);
    print(body);
    _dataPemesanan.clear();
    if (body['data'].length > 1) {
      for (int i = 0; i < body['data'].keys.toList().length; i++) {
        String key = body['data'].keys.toList()[i];
        _dataPemesanan.add(Pemesanan(
            id: body['data'][key]['id'],
            invoice: body['data'][key]['invoice'],
            idUser: body['data'][key]['user_id'],
            namaUser: 'null',
            nomorHp: 'null',
            idStudio: body['data'][key]['studio_id'],
            namaStudio: 'null',
            alamatStudio: 'null',
            tanggal: DateTime.parse(body['data'][key]['tanggal']),
            totalPembayaran: body['data'][key]['total_tarif'],
            status: body['data'][key]['status'],
            dedline: DateTime.parse(body['data'][key]['dedline']),
            fasilitasDipesan:
                jsonDecode(body['data'][key]['fasilitas_dipesan'])));
      }
    } else {
      _dataPemesanan.clear();

      for (int i = 0; i < body['data'].length; i++) {
        _dataPemesanan.add(Pemesanan(
            id: body['data'][i]['id'],
            invoice: body['data'][i]['invoice'],
            idUser: body['data'][i]['user_id'],
            namaUser: 'null',
            nomorHp: 'null',
            idStudio: body['data'][i]['studio_id'],
            namaStudio: 'null',
            alamatStudio: 'null',
            tanggal: DateTime.parse(body['data'][i]['tanggal']),
            totalPembayaran: body['data'][i]['total_tarif'],
            status: body['data'][i]['status'],
            dedline: DateTime.parse(body['data'][i]['dedline']),
            fasilitasDipesan:
                jsonDecode(body['data'][i]['fasilitas_dipesan'])));
        print(body['data'][i]['invoice']);
      }
    }
    _userData = body['user_data'];
    if (body['image_studio'].toList().isNotEmpty) {
      String url = Network().url + '/storage/';
      _imageStudio = url + body['image_studio'][0]['image'];
      print(_imageStudio);
    }
    print('panjang data = ' + _dataPemesanan.length.toString());
  }

  getPemesananPenyediaLangsung() async {
    var res = await Network().getData('/pemesanan/langsung/penyedia/show');
    var body = jsonDecode(res.body);

    _dataPemesanan.clear();
    if (body['data'].length > 1) {
      for (int i = 0; i < body['data'].keys.toList().length; i++) {
        String key = body['data'].keys.toList()[i];
        _dataPemesanan.add(Pemesanan(
            id: body['data'][key]['id'],
            invoice: body['data'][key]['invoice'],
            idUser: 0,
            namaUser: body['data'][key]['nama_user'],
            nomorHp: body['data'][key]['nomor_hp'],
            idStudio: body['data'][key]['studio_id'],
            namaStudio: 'null',
            alamatStudio: 'null',
            tanggal: DateTime.parse(body['data'][key]['tanggal']),
            totalPembayaran: body['data'][key]['total_tarif'],
            status: body['data'][key]['status'],
            dedline: DateTime.parse(body['data'][key]['dedline']),
            fasilitasDipesan:
                jsonDecode(body['data'][key]['fasilitas_dipesan'])));
      }
    } else {
      _dataPemesanan.clear();

      for (int i = 0; i < body['data'].length; i++) {
        _dataPemesanan.add(Pemesanan(
            id: body['data'][i]['id'],
            invoice: body['data'][i]['invoice'],
            idUser: 0,
            namaUser: body['data'][i]['nama_user'],
            nomorHp: body['data'][i]['nomor_hp'],
            idStudio: body['data'][i]['studio_id'],
            namaStudio: 'null',
            alamatStudio: 'null',
            tanggal: DateTime.parse(body['data'][i]['tanggal']),
            totalPembayaran: body['data'][i]['total_tarif'],
            status: body['data'][i]['status'],
            dedline: DateTime.parse(body['data'][i]['dedline']),
            fasilitasDipesan:
                jsonDecode(body['data'][i]['fasilitas_dipesan'])));
        print(body['data'][i]['invoice']);
      }
    }
    //_userData = body['user_data'];
    if (body['image_studio'].toList().isNotEmpty) {
      String url = 'http://192.168.5.107:8000/storage/';
      _imageStudio = url + body['image_studio'][0]['image'];
      print(_imageStudio);
    }
  }

  String _imageStudio =
      'https://www.dauhpurikangin.id/uploads/default/noimages.png';

  String get imageStudio => _imageStudio;
  set imageStudio(String value) {
    _imageStudio = value;
    notifyListeners();
  }

  dynamic _userData;
  dynamic get userData => _userData;
  set userData(dynamic value) {
    _userData = value;
    notifyListeners();
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
