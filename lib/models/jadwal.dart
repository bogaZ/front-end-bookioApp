import 'package:flutter/widgets.dart';

class Jadwal with ChangeNotifier {
  int id;
  int idStudio;
  String hari;
  String jamBuka;
  String jamTutup;
  bool status;
  Jadwal(this.id, this.idStudio, this.hari, this.jamBuka, this.jamTutup,
      this.status);

  statusAktif() {
    status = !status;
    notifyListeners();
  }
}
