import 'package:bookio2/models/Notifikasi.dart';
import 'package:bookio2/page/Notifikasi.dart';
import 'package:flutter/widgets.dart';

class NotifikasiProvider with ChangeNotifier {
  List<NotifikasiModels> _dataNotifikasi = [
    NotifikasiModels(
      judul: "Pemesanan Ruang 3",
      deskripsi: "budi setiawan status menunggu pembayaran",
      tanggal: "2022-08-06",
      link: "/DetailPemesananMelaluiAplikasi",
      status: false,
    ),
    NotifikasiModels(
      judul: "Pemesanan Ruang 2",
      deskripsi: "budi setiawan status menunggu pembayaran",
      tanggal: "2022-08-06",
      link: "/DetailPemesananMelaluiAplikasi",
      status: false,
    ),
  ];
  List<NotifikasiModels> get dataNotifikasi => _dataNotifikasi;
  set dataNotifikasi(List<NotifikasiModels> value) {
    _dataNotifikasi = value;
    notifyListeners();
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
