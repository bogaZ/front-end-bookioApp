import 'package:bookio2/models/RuangDipesan.dart';
import 'package:flutter/widgets.dart';

class RuangDipesanProvider with ChangeNotifier {
  // DATA //! RUANG YANG DIPESAN SESUAI DENGAN ID PEMESANAN
  List<RuangDipesan> _dataRuangDipesan = [];
  List<RuangDipesan> get dataRuangDipesan => _dataRuangDipesan;
}
