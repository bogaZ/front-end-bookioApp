import 'package:bookio2/models/Pemesanan.dart';
import 'package:flutter/widgets.dart';

class PemesananLangsungProvider with ChangeNotifier {
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
    // Pemesanan(
    //     idPemesanan: "1",
    //     kodeTransaksi: "789789uihh",
    //     idUser: "1",
    //     namaUser: "Andi Setyawanto",
    //     nomerHp: "089766755744",
    //     idStudio: "0",
    //     namaStudio: "Studio 1",
    //     tanggal: "2022-06-29",
    //     totalDurasi: 4,
    //     totalPembayaran: 200000,
    //     status: "Menunggu pemebayaran")
  ];
  List<Pemesanan> get dataPemesanan => _dataPemesanan;
  set dataPemesanan(List<Pemesanan> value) {
    _dataPemesanan = value;
    notifyListeners();
  }
}
