import 'dart:convert';

import 'package:bookio2/alert/JamBerurutan.dart';
import 'package:bookio2/alert/MaksimalPemesanan.dart';
import 'package:bookio2/models/Pemesanan.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/jam.dart';
import 'package:bookio2/models/ruang.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/jadwal.dart';
import '../models/RuangDipesan.dart';

class PilihJadwalProvider with ChangeNotifier {
  // MEMBUTUHKAN //! CONTEXT UNTUK MENJALANKAN ALERT!!
  BuildContext context;
  StudioProvider studioProvider;
  int idStudio;
  PilihJadwalProvider({
    required this.idStudio,
    required this.studioProvider,
    required this.context,
  }) {
    if (studioProvider.dataRuang.isNotEmpty) {
      ambilData();
      dataRuang.forEach((element) => element.status = false);
      dataRuang.first.status = true;
      listJam();
      listHandleJam();
      listJamDipilih();
      ambilIdRuang();
    }
    if (studioProvider.jadwal.isNotEmpty) {
      ambilDataJadwal();
    }
  }

  List<Jadwal> _mydataJadwal = [
    // Jadwal("0", "0", "Monday", "08:00", "22:00", false),
    // Jadwal("2", "0", "Tuesday", "08:00", "22:00", false),
    // Jadwal("3", "0", "Wednesday", "08:00", "22:00", false),
    // Jadwal("4", "0", "Thursday", "08:00", "24:00", false),
    // Jadwal("2", "0", "Friday", "08:00", "22:00", false),
    // Jadwal("2", "0", "Saturday", "08:00", "22:00", false),
    // Jadwal("2", "1", "Saturday", "08:00", "23:00", false),
    // Jadwal("2", "1", "Sunday", "10:00", "23:00", false),
  ];
  List<Jadwal> get mydataJadwal => _mydataJadwal;

  // DATA DUMMY //! ALL RUANG STUDIO
  List<Ruang> _mydataRuang = [
    Ruang(id: 0, idStudio: 1, nama: "Ruang 1", tarif: 15000),
    Ruang(id: 1, idStudio: 1, nama: "Ruang 2", tarif: 20000),
    Ruang(id: 2, idStudio: 1, nama: "Vip", tarif: 30000),
    Ruang(id: 3, idStudio: 2, nama: "Vip2", tarif: 30000),
    Ruang(id: 4, idStudio: 2, nama: "Vip3", tarif: 30000),
  ];
  List<Ruang> get mydataRuang => _mydataRuang;

  // MENGAMBIL //! DATA JADWAL UNTUK DITAMPUNG PADA PROVIDER
  //? BERDASARKAN ID STUDIO YANG DIDAPAT
  List<Jadwal> _dataJadwal = [];
  List<Jadwal> get dataJadwal => _dataJadwal;
  set dataJadwal(List<Jadwal> value) {
    _dataJadwal = value;
    notifyListeners();
  }

  ambilDataJadwal() {
    dataJadwal = studioProvider.jadwal;
  }

  cekJadwal(int index) {
    final data =
        dataJadwal.where((element) => element.hari == ambilHari()).toList();
    if (data.first.status) {
      int jamBuka = dataJam
          .indexWhere((element) => element.namaJam == data.first.jamBuka);
      int jamTutup = dataJam
          .indexWhere((element) => element.namaJam == data.first.jamTutup);
      if (index >= jamBuka && index < jamTutup) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // MENGAMBIL //! DATA RUANG UNTUK DITAMPUNG PADA PROVIDER
  //? BERDASARKAN ID STUDIO YANG DIDAPAT
  List<Ruang> _dataRuang = [];
  List<Ruang> get dataRuang => _dataRuang;
  set dataRuang(List<Ruang> value) {
    _dataRuang = value;
    notifyListeners();
  }

  int _indexRuang = 0;
  int get indexRuang => _indexRuang;
  set indexRuang(int value) {
    _indexRuang = value;
    notifyListeners();
  }

  // COUNTER //! COUNTER
  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  // DATA //! JAM
  List<Jam> _dataJam = List.generate(
      25,
      (index) => Jam(
          namaJam: index < 10
              ? "0" + index.toString() + ":00"
              : index.toString() + ":00"));
  List<Jam> get dataJam => _dataJam;
  set dataJam(List<Jam> value) {
    _dataJam = value;
    notifyListeners();
  }

  List<dynamic> listOfJam = [];
  listJam() {
    listOfJam = List.generate(
        dataRuang.length, (index) => List.generate(24, (index) => false));
  }

  List<Map<String, dynamic>> handleJam = [];
  listHandleJam() {
    handleJam = List.generate(
        dataRuang.length,
        (index) => {
              "jamAwal": null,
              "jamAkhir": null,
              "tarif": 0,
            });
  }

  List<List<int>> _jamDipilih = [];
  List<List<int>> get jamDipilih => _jamDipilih;
  set jamDipilih(List<List<int>> value) {
    _jamDipilih = value;
    notifyListeners();
  }

  listJamDipilih() {
    jamDipilih = List.generate(dataRuang.length, (index) => []);
  }

  int jamMaksimal = 3;

  // METHOD //! SAAT JAM DI TAB
  tabJam(int index) {
    cekTabJam(index);
  }

  cekTabJam(int index) {
    bool status = listOfJam[indexRuang][index];
    if (status == false) {
      if (jamDipilih[indexRuang].length == jamMaksimal) {
        print("Maksimal pemesanan ${jamMaksimal} jam");
        MaksimalPemesanan(nilai: jamMaksimal).maksimalPemesanan(context);
      } else {
        handleJamFalse(index);
      }
    } else if (status == true) {
      handelJamTrue(index);
    }
  }

  handleJamFalse(int index) {
    final jamAwal = handleJam.map((e) => e["jamAwal"]).toList()[indexRuang];
    final jamAhir = handleJam.map((e) => e["jamAkhir"]).toList()[indexRuang];
    if (jamAwal == null && jamAhir == null) {
      handleJam[indexRuang].update("jamAwal", (value) => index);
      handleJam[indexRuang].update("jamAkhir", (value) => index + 1);
      handleJam[indexRuang].update(
        "tarif",
        (value) => value += dataRuang[indexRuang].tarif,
      );
      listOfJam[indexRuang][index] = !listOfJam[indexRuang][index];
      jamDipilih[indexRuang].add(index);
      totalDuration += 1;
      totalPembayaran += dataRuang[indexRuang].tarif;
      tampungRuang();
    } else if (index == jamAhir) {
      handleJam[indexRuang].update("jamAkhir", (value) => index + 1);
      handleJam[indexRuang].update(
        "tarif",
        (value) => value += dataRuang[indexRuang].tarif,
      );
      listOfJam[indexRuang][index] = !listOfJam[indexRuang][index];
      jamDipilih[indexRuang].add(index);
      totalDuration += 1;
      totalPembayaran += dataRuang[indexRuang].tarif;
      tampungRuang();
    } else if (index + 1 == jamAwal) {
      handleJam[indexRuang].update("jamAwal", (value) => index);
      handleJam[indexRuang].update(
        "tarif",
        (value) => value += dataRuang[indexRuang].tarif,
      );
      listOfJam[indexRuang][index] = !listOfJam[indexRuang][index];
      jamDipilih[indexRuang].add(index);
      totalPembayaran += dataRuang[indexRuang].tarif;
      totalDuration += 1;
      tampungRuang();
    } else {
      JamBerurutan().harusBerurutan(context);
      print("Jam Harus Berurutan");
    }
  }

  handelJamTrue(int index) {
    final jamAwal = handleJam.map((e) => e["jamAwal"]).toList()[indexRuang];
    final jamAhir = handleJam.map((e) => e["jamAkhir"]).toList()[indexRuang];
    if (jamAhir - 1 == jamAwal) {
      handleJam[indexRuang].update("jamAwal", (value) => null);
      handleJam[indexRuang].update("jamAkhir", (value) => null);
      handleJam[indexRuang].update(
        "tarif",
        (value) => value -= dataRuang[indexRuang].tarif,
      );
      listOfJam[indexRuang][index] = !listOfJam[indexRuang][index];
      jamDipilih[indexRuang].remove(index);
      totalDuration -= 1;
      totalPembayaran -= dataRuang[indexRuang].tarif;
      removeTampungRuang();
    } else if (index == jamAhir - 1) {
      handleJam[indexRuang].update("jamAkhir", (value) => index);
      handleJam[indexRuang].update(
        "tarif",
        (value) => value -= dataRuang[indexRuang].tarif,
      );
      listOfJam[indexRuang][index] = !listOfJam[indexRuang][index];
      jamDipilih[indexRuang].remove(index);
      totalDuration -= 1;
      totalPembayaran -= dataRuang[indexRuang].tarif;
      tampungRuang();
    } else if (index == jamAwal) {
      handleJam[indexRuang].update("jamAwal", (value) => index + 1);
      handleJam[indexRuang].update(
        "tarif",
        (value) => value -= dataRuang[indexRuang].tarif,
      );
      listOfJam[indexRuang][index] = !listOfJam[indexRuang][index];
      jamDipilih[indexRuang].remove(index);
      totalDuration -= 1;
      totalPembayaran -= dataRuang[indexRuang].tarif;
      tampungRuang();
    }
  }

  // MENGAMBIL //! DATA RUANG BERDASARKAN ID STUDIO YANG DIDAPAT
  ambilData() {
    dataRuang = studioProvider.dataRuang;
    print(dataRuang.length);
    print(studioProvider.dataRuang);
    notifyListeners();
  }

  // METHOD //! TAB RUANG
  //? Untuk mengontrol ButtonRuang ketika di Tab
  tabRuang(int index) {
    for (int i = 0; i < dataRuang.length; i++) {
      if (index == i) {
        dataRuang[i].status = true;
      } else {
        dataRuang[i].status = false;
      }
    }
  }

  // DATA //! KALENDER
  //? SEMUA DATA DAN LOGIC DARI KALENDER
  DateTime _tanggalDipilih = DateTime.now();
  DateTime get tanggalDipilih => _tanggalDipilih;
  set tanggalDipilih(DateTime value) {
    _tanggalDipilih = value;
    notifyListeners();
  }

  DateTime _fokusTanggal = DateTime.now();
  DateTime get fokusTanggal => _fokusTanggal;
  set fokusTanggal(DateTime value) {
    _fokusTanggal = value;
    notifyListeners();
  }

  String ambilHari() {
    String hari = DateFormat.EEEE().format(tanggalDipilih);
    return hari;
  }

  cekTanggal(int index) {
    print("proses");
    int tahunSekarang = int.parse(DateFormat.y().format(DateTime.now()));
    int bulanSekarang = int.parse(DateFormat.M().format(DateTime.now()));
    int hariSekarang = int.parse(DateFormat.d().format(DateTime.now()));

    int jamDipilih = int.parse(DateFormat.H().format(DateTime.now()));
    int tahunDipilih = int.parse(DateFormat.y().format(tanggalDipilih));
    int bulanDipilih = int.parse(DateFormat.M().format(tanggalDipilih));
    int hariDipilih = int.parse(DateFormat.d().format(tanggalDipilih));

    // if (tahunDipilih < tahunSekarang) {
    //   if (bulanDipilih >= bulanSekarang) {
    //     if (hariDipilih > hariSekarang) {
    //       return true;
    //     } else if (index > jamDipilih) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return false;
    // }

    if (tahunDipilih > tahunSekarang) {
      return true;
    } else if (bulanDipilih > bulanSekarang) {
      return true;
    } else if (hariDipilih > hariSekarang) {
      return true;
    } else if (index > jamDipilih) {
      return true;
    } else {
      return false;
    }
  }

  // METHOD //! MENGAMBIL ID RUANG YANG DIPILIH
  ambilIdRuang() {
    int idRuang = dataRuang[indexRuang].id;

    return idRuang;
  }

  // VARIABEL //! UNTUK MENAMPUNG TOTAL KESELUUHAN DURASI YANG DIPESAN
  int _totalDuration = 0;
  int get totalDuration => _totalDuration;
  set totalDuration(int value) {
    _totalDuration = value;
    notifyListeners();
  }

  // VARIABEL //! TOTAL SEMUA PEMBAYARAN
  double _totalPembayaran = 0;
  double get totalPembayaran => _totalPembayaran;
  set totalPembayaran(double value) {
    _totalPembayaran = value;
    notifyListeners();
  }

  // VARIABEL //! MENAMPUNG RUANG - RUANG YANG DIPILIH
  List<Map<String, dynamic>> _tampungRuangDipesan = [];
  List<Map<String, dynamic>> get tampungRuangDipesan => _tampungRuangDipesan;
  set tampungRuangDipesan(List<Map<String, dynamic>> value) {
    _tampungRuangDipesan = value;
    notifyListeners();
  }

  tampungRuang() {
    final data = tampungRuangDipesan
        .where((element) => element["idRuang"] == dataRuang[indexRuang].id)
        .toList();
    if (data.isEmpty) {
      tampungRuangDipesan.add({
        "idRuang": dataRuang[indexRuang].id,
        "namaRuang": dataRuang[indexRuang].nama,
        "jamAwal": handleJam[indexRuang]["jamAwal"] < 10
            ? "0" + handleJam[indexRuang]["jamAwal"].toString() + ":00"
            : handleJam[indexRuang]["jamAwal"].toString() + ":00",
        "jamAkhir": handleJam[indexRuang]["jamAkhir"] < 10
            ? "0" + handleJam[indexRuang]["jamAkhir"].toString() + ":00"
            : handleJam[indexRuang]["jamAkhir"].toString() + ":00",
        "tarif": handleJam[indexRuang]["tarif"]
      });
    } else {
      tampungRuangDipesan
          .where((element) => element['idRuang'] == dataRuang[indexRuang].id)
          .toList()
          .first
          .update("tarif", (value) => handleJam[indexRuang]["tarif"]);
      tampungRuangDipesan
          .where((element) => element['idRuang'] == dataRuang[indexRuang].id)
          .toList()
          .first
          .update(
            "jamAwal",
            (value) => handleJam[indexRuang]["jamAwal"] < 10
                ? "0" + handleJam[indexRuang]["jamAwal"].toString() + ":00"
                : handleJam[indexRuang]["jamAwal"].toString() + ":00",
          );
      tampungRuangDipesan
          .where((element) => element['idRuang'] == dataRuang[indexRuang].id)
          .toList()
          .first
          .update(
              "jamAkhir",
              (value) => handleJam[indexRuang]["jamAkhir"] < 10
                  ? "0" + handleJam[indexRuang]["jamAkhir"].toString() + ":00"
                  : handleJam[indexRuang]["jamAkhir"].toString() + ":00");
    }
  }

  removeTampungRuang() {
    tampungRuangDipesan.removeWhere(
        (element) => element["idRuang"] == dataRuang[indexRuang].id);
  }

  printData() {
    print(tampungRuangDipesan);
  }

  String _namaUser = "";
  String get namaUser => _namaUser;
  set namaUser(String value) {
    _namaUser = value;
    notifyListeners();
  }

  String _nomerHp = "";
  String get nomerHp => _nomerHp;
  set nomerHp(String value) {
    _nomerHp = value;
    notifyListeners();
  }

  List<RuangDipesan> _dataRuangDipesan = [
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

  set dataRuangDipesan(List<RuangDipesan> value) {
    _dataRuangDipesan = value;
    notifyListeners();
  }

  getDataPemesanan(var data) {
    _dataRuangDipesan = data;
  }

  sudahDipesan(int index) {
    final data = dataRuangDipesan
        .where((element) =>
            element.idRuang == ambilIdRuang() &&
            element.tanggal == tanggalDipilih.toString().substring(0, 10))
        .toList();
    if (data.isNotEmpty) {
      final mydata = data.where((element) =>
          index >=
              dataJam.indexWhere(
                  (element2) => element2.namaJam == element.jamAwal) &&
          index <
              dataJam.indexWhere(
                  (element2) => element2.namaJam == element.jamAkhir) &&
          element.status != 'Kadaluarsa');
      if (mydata.isNotEmpty) {
        final myData3 = mydata.where((element) =>
            element.status == 'Menunggu Konfirmasi' ||
            element.status == 'Berhasil Dipesan');

        if (myData3.isNotEmpty) {
          return false;
        } else {
          final myData2 = mydata.where((element) =>
              (element.status == 'Menunggu Pembayaran' ||
                  element.status == 'Dibatalkan') &&
              cekDedline(element.dedline) == true);
          if (myData2.isNotEmpty) {
            return false;
          } else {
            return true;
          }
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  cekDedline(DateTime tanggal) {
    DateTime dedlinenya = tanggal;
    DateTime sekarang = DateTime.now();

    // int tahunSekarang = int.parse(DateFormat.y().format(DateTime.now()));
    // int bulanSekarang = int.parse(DateFormat.M().format(DateTime.now()));
    // int hariSekarang = int.parse(DateFormat.d().format(DateTime.now()));
    // int jamSekarang = int.parse(DateFormat.H().format(DateTime.now()));
    // int menitSekarang = int.parse(DateFormat.m().format(DateTime.now()));

    if (dedlinenya.isAfter(sekarang)) {
      return true;
    } else {
      return false;
    }
  }
}
