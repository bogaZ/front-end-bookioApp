import 'dart:async';
import 'dart:convert';

import 'package:bookio2/models/WithdrawModels.dart';
import 'package:bookio2/page/penyedia/Withdraw.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/widgets.dart';

class WithdrawServices with ChangeNotifier {
  List<WithdrawModels> _dataWithdraw = [];
  List<WithdrawModels> get dataWithdraw => _dataWithdraw;
  set dataWithdraw(List<WithdrawModels> value) {
    _dataWithdraw = value;
    notifyListeners();
  }

  // MELAKUKAN REQUEST DATA WITDRAW
  getDataWithdraw(BuildContext context) async {
    final res = await Network().getData('/withdraw/show');
    _dataWithdraw.clear();
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body)['data'];
      print(body);
      if (body.length > 1) {
        for (int i = body.length - 1; i >= 0; i -= 1) {
          _dataWithdraw.add(WithdrawModels(
              tanggal: body[i.toString()]['created_at'],
              nominal: body[i.toString()]['jumlah'],
              status: body[i.toString()]['status']));
        }
      } else {
        _dataWithdraw = [
          WithdrawModels(
              tanggal: body.first['created_at'],
              nominal: body.first['jumlah'],
              status: body.first['status'])
        ];
      }
    }
  }

  // MELAKUKAN REQUEST WITHDRAW
  requestWithdraw(var data, BuildContext context) async {
    var res = await Network().postData(data, '/withdraw');
    var body = await json.decode(res.body);
    print(body);
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
