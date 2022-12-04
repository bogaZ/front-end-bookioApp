// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:bookio2/models/WithdrawModels.dart';
import 'package:bookio2/page/penyedia/Withdraw.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/widgets.dart';

class WithdrawProvider with ChangeNotifier {
  bool _isLoadingWithdraw = false;
  bool get isLoadingWithdraw => _isLoadingWithdraw;
  set isLoadingWithdraw(bool value) {
    _isLoadingWithdraw = value;
    notifyListeners();
  }

  WithdrawProvider() {
    //getDataWithdraw();
  }

  List<WithdrawModels> _dataWithdraw = [
    // WithdrawModels(
    //     tanggal: DateTime.now().toString().substring(0, 10), nominal: 100000),
    // WithdrawModels(
    //     tanggal: DateTime.now().toString().substring(0, 10), nominal: 200000)
  ];
  List<WithdrawModels> get dataWithdraw => _dataWithdraw;
  set dataWithdraw(List<WithdrawModels> value) {
    _dataWithdraw = value;
    notifyListeners();
  }

  getDataWithdraw(var data) {
    _dataWithdraw = data;
  }

  // // MELAKUKAN REQUEST DATA WITDRAW

  // getDataWithdraw(BuildContext context) async {
  //   final res = await Network().getData('/withdraw/show');
  //   _dataWithdraw.clear();
  //   if (res.statusCode == 200) {
  //     final body = jsonDecode(res.body)['data'];
  //     print(body);
  //     if (body.length > 1) {
  //       for (int i = body.length - 1; i >= 0; i -= 1) {
  //         _dataWithdraw.add(WithdrawModels(
  //             tanggal: body[i.toString()]['created_at'],
  //             nominal: body[i.toString()]['jumlah'],
  //             status: body[i.toString()]['status']));
  //       }
  //     } else {
  //       _dataWithdraw = [
  //         WithdrawModels(
  //             tanggal: body.first['created_at'],
  //             nominal: body.first['jumlah'],
  //             status: body.first['status'])
  //       ];
  //     }
  //   }
  // }

  // // MELAKUKAN REQUEST WITHDRAW
  // requestWithdraw(var data, BuildContext context) async {
  //   var res = await Network().postData(data, '/withdraw');
  //   var body = await json.decode(res.body);
  // }

  // DATA JUMLAH //! WITHDRAW YANG DAPAT DILAKUKAN
  List<int> _jumlahWithdraw = [
    10000,
    50000,
    100000,
    300000,
    500000,
    1000000,
  ];
  List<int> get jumlahWithdraw => _jumlahWithdraw;
  set jumlahWithdraw(List<int> value) {
    _jumlahWithdraw = value;
    notifyListeners();
  }

  int _totalJumlah = 0;
  int get totalJumlah => _totalJumlah;
  set totalJumlah(int value) {
    _totalJumlah = value;
    notifyListeners();
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
