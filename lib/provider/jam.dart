import 'package:flutter/widgets.dart';

class Jam with ChangeNotifier {
  String namaJam;
  bool status;
  Jam({required this.namaJam, this.status = false});

  tabJam() {
    status = !status;
    //print(status);
    notifyListeners();
  }

  statusnya() {
    //print("proses2");
    return status;
  }
}
