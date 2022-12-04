import 'package:flutter/widgets.dart';

class Ruang with ChangeNotifier {
  int id;
  int idStudio;
  String nama;
  int tarif;
  bool status;
  Ruang(
      {required this.id,
      required this.idStudio,
      required this.nama,
      required this.tarif,
      this.status = false});

  statusaktif() {
    status = !status;
  }
}
