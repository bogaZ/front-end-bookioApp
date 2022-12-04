import 'dart:convert';

import 'package:bookio2/models/ruang.dart';
import 'package:bookio2/page/penyedia/KelolaRuangStudio.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../page/penyedia/KelolaStudio.dart';

class RuangProvider with ChangeNotifier {
  RuangProvider() {
    dataRuang =
        mydataRuang.where((element) => element.idStudio == idStudio).toList();
  }
  // DATA DUMMY //! ALL RUANG STUDIO
  List<Ruang> _mydataRuang = [
    // Ruang(id: "0", idStudio: "1", nama: "Ruang 1", tarif: 15000),
    // Ruang(id: "1", idStudio: "1", nama: "Ruang 2", tarif: 20000),
    // Ruang(id: "2", idStudio: "0", nama: "Vip", tarif: 30000),
    // Ruang(id: "3", idStudio: "0", nama: "Vip2", tarif: 30000),
    // Ruang(id: "4", idStudio: "0", nama: "Vip3", tarif: 30000),
  ];
  List<Ruang> get mydataRuang => _mydataRuang;
  set mydataRuang(List<Ruang> value) {
    _mydataRuang = value;
    notifyListeners();
  }

  // DATA RUANG MILIK PENYEDIA TEMPAT STUDIO
  List<Ruang> _ruangPenyedia = [];
  List<Ruang> get ruangPenyedia => _ruangPenyedia;
  set ruangPenyedia(List<Ruang> value) {
    _ruangPenyedia = value;
    notifyListeners();
  }

  // Get mengambil semua data ruang yang dimiliki
  getDataRuang() async {
    var res = await Network().getData('/studio/fasilitas/show');
    var body = jsonDecode(res.body);
    print(body['data']);

    if (body['success']) {
      _ruangPenyedia = List.generate(
          body['data'].length,
          (index) => Ruang(
              id: body['data'][index]['id'],
              idStudio: body['data'][index]['studio_id'],
              nama: body['data'][index]['nama_fasilitas'],
              tarif: body['data'][index]['tarif']));
    }
  }

  // POST data untuk menyimpan dan menambah fasilitas ruang
  postDataRuang(var data, BuildContext context) async {
    var res = await Network().postData(data, '/studio/fasilitas/add');
    var body = jsonDecode(res.body);
    print(body);
    if (body['success']) {
      _fetchData(context);
    }
  }

  // DELETE untuk menghapus data fasilitas
  deleteDataFasilitas(var id, BuildContext context) async {
    print('delete data');
    print('/studio/fasilitas/delete/${id}');
    var res = await Network().deleteData('/studio/fasilitas/delete/${id}');
    var body = jsonDecode(res.body);
    if (body['success']) {
      _fetchData(context);
      //Navigator.pushNamed(context, KelolaRuangStudio.routeName);
    }
  }

  // UPDATE DATA FASILITAS RUANG STUDIO
  updateDataFasilitas(var data, var id, BuildContext context) async {
    print(data);
    print(id);
    var res = await Network().putData(data, '/studio/fasilitas/update/${id}');
    var body = jsonDecode(res.body);
    print(body);
    //_fetchData(context);
  }

  void _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 1));

    // Close the dialog programmatically
    Navigator.of(context).pop();
    //getDataStudio(context, '/kelolaStudio');
    counter += 1;
  }

  List<Ruang> _dataRuang = [];
  List<Ruang> get dataRuang => _dataRuang;
  set dataRuang(List<Ruang> value) {
    _dataRuang = value;
    notifyListeners();
  }
  // hapusRuang(List<Ruang> value) {
  //   dataRuang.remove(value);
  // }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  String idStudio = "0";
  tambahRuang(String nama, int tarif) {
    // dataRuang
    //     .add(Ruang(id: "null", idStudio: idStudio, nama: nama, tarif: tarif));
  }
}
