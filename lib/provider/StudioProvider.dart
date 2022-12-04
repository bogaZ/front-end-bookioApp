import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/models/ruang.dart';
import 'package:bookio2/page/penyedia/FirstLogin/TambahDataStudio.dart';
import 'package:bookio2/page/penyedia/KelolaStudio.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../models/Studios.dart';
import 'package:flutter/cupertino.dart';

class StudioProvider with ChangeNotifier {
  String url = Network().url + '/storage/';
  //String url = 'http://192.168.39.245:8000/storage/';
  // DATA DUMMY //! ALL STUDIO MUSIK
  List<Studios> _allStudio = [
    Studios(1, 'nama', 'alamat', 'deskripsi', 0, 0, 9, 9, [], [],
        'Belum Terverifikasi', 'Nonaktif')
  ];
  List<Studios> get allStudio => _allStudio;
  set allStudio(List<Studios> value) {
    _allStudio = value;
    notifyListeners();
  }

  //GET Semua Data Studio
  getAllDataStudio() async {
    print('Semua data Studio');
    var res = await Network().getData('/penyewa/studio/show');
    var body = jsonDecode(res.body);
    _myStudio.clear();
    for (int index = 0; index < body['data'].length; index++) {
      if (body['data'][index]['status_transaksi'] == 'Aktif' &&
          body['data'][index]['status_tempat'] == 'Terverifikasi') {
        _myStudio.add(Studios(
          body['data'][index]['id'],
          body['data'][index]['nama_studio'],
          body['data'][index]['alamat'],
          body['data'][index]['deskripsi'],
          body['data'][index]['rating'] * 1.0,
          0,
          body['data'][index]['tarif_minimal'],
          body['data'][index]['tarif_maksimal'],
          body['image_data']
                  .where((element) =>
                      element['studio_id'] == body['data'][index]['id'])
                  .toList()
                  .isNotEmpty
              ? List.generate(
                  body['image_data']
                      .where((element) =>
                          element['studio_id'] == body['data'][index]['id'])
                      .toList()
                      .length,
                  (i) =>
                      url +
                      body['image_data']
                          .where((element) =>
                              element['studio_id'] == body['data'][index]['id'])
                          .toList()[i]['image']
                          .toString())
              : image,
          [0],
          body['data'][index]['status_tempat'],
          body['data'][index]['status_transaksi'],
        ));
      }
    }

    // _myStudio = List.generate(
    //     body['data'].length,
    //     (index) => Studios(
    //           body['data'][index]['id'],
    //           body['data'][index]['nama_studio'],
    //           body['data'][index]['alamat'],
    //           body['data'][index]['deskripsi'],
    //           body['data'][index]['rating'] * 1.0,
    //           0,
    //           body['data'][index]['tarif_minimal'],
    //           body['data'][index]['tarif_maksimal'],
    //           body['image_data']
    //                   .where((element) =>
    //                       element['studio_id'] == body['data'][index]['id'])
    //                   .toList()
    //                   .isNotEmpty
    //               ? List.generate(
    //                   body['image_data']
    //                       .where((element) =>
    //                           element['studio_id'] == body['data'][index]['id'])
    //                       .toList()
    //                       .length,
    //                   (i) =>
    //                       url +
    //                       body['image_data']
    //                           .where((element) =>
    //                               element['studio_id'] ==
    //                               body['data'][index]['id'])
    //                           .toList()[i]['image']
    //                           .toString())
    //               : image,
    //           [0],
    //           body['data'][index]['status_tempat'],
    //           body['data'][index]['status_transaksi'],
    //         ));
    pencarian(_cari);
    print(_allStudio.first.image);
  }

  allDataStudio() async {
    print('Semua data Studio');
    var res = await Network().getData('/penyewa/studio/allshow');
    var body = jsonDecode(res.body);

    _myStudio = List.generate(
        body['data'].length,
        (index) => Studios(
              body['data'][index]['id'],
              body['data'][index]['nama_studio'],
              body['data'][index]['alamat'],
              body['data'][index]['deskripsi'],
              body['data'][index]['rating'] * 1.0,
              0,
              body['data'][index]['tarif_minimal'],
              body['data'][index]['tarif_maksimal'],
              body['image_data']
                      .where((element) =>
                          element['studio_id'] == body['data'][index]['id'])
                      .toList()
                      .isNotEmpty
                  ? List.generate(
                      body['image_data']
                          .where((element) =>
                              element['studio_id'] == body['data'][index]['id'])
                          .toList()
                          .length,
                      (i) =>
                          url +
                          body['image_data']
                              .where((element) =>
                                  element['studio_id'] ==
                                  body['data'][index]['id'])
                              .toList()[i]['image']
                              .toString())
                  : image,
              [0],
              body['data'][index]['status_tempat'],
              body['data'][index]['status_transaksi'],
            ));
    pencarian(_cari);
    print(_allStudio.first.image);
  }

  // DetailStudio
  Studios _detailStudio = Studios(0, '', '', '', 0, 0, 0, 0, [], [0], '', '');
  Studios get detailStudio => _detailStudio;
  set detailStudio(Studios value) {
    _detailStudio = value;
    notifyListeners();
  }

  // Fasilitas Ruang
  List<Ruang> _dataRuang = [];
  List<Ruang> get dataRuang => _dataRuang;
  set dataRuang(List<Ruang> value) {
    _dataRuang = value;
    notifyListeners();
  }

  // GET Detail studio
  getDetailStudio(var id) async {
    var res = await Network().getData('/penyewa/studio/show/${id}');
    var body = jsonDecode(res.body);

    _detailStudio = Studios(
      body['studio']['id'],
      body['studio']['nama_studio'],
      body['studio']['alamat'],
      body['studio']['deskripsi'],
      body['studio']['rating'] * 1.0,
      0,
      body['studio']['tarif_minimal'],
      body['studio']['tarif_maksimal'],
      body['image_data'].toList().isNotEmpty
          ? List.generate(body['image_data'].toList().length,
              (index) => url + body['image_data'].toList()[index]['image'])
          : image,
      [0],
      body['studio']['status_tempat'],
      body['studio']['status_transaksi'],
    );
    _jumlahFasilitas = body['fasilitas'].length;

    _dataRuang = List.generate(
        body['fasilitas'].length,
        (index) => Ruang(
            id: body['fasilitas'][index]['id'],
            idStudio: body['fasilitas'][index]['studio_id'],
            nama: body['fasilitas'][index]['nama_fasilitas'],
            tarif: body['fasilitas'][index]['tarif']));

    _jadwal = List.generate(
        body['jadwal'].length,
        (index) => Jadwal(
            body['jadwal'][index]['id'],
            body['jadwal'][index]['studio_id'],
            body['jadwal'][index]['nama_hari'],
            body['jadwal'][index]['jam_buka'],
            body['jadwal'][index]['jam_tutup'],
            body['jadwal'][index]['status'] == 0 ? false : true));
    print(dataRuang);
  }

  List<Jadwal> _jadwal = [];
  List<Jadwal> get jadwal => _jadwal;
  set jadwal(List<Jadwal> value) {
    _jadwal = value;
    notifyListeners();
  }

  // Jumlah Fasilitas
  int _jumlahFasilitas = 0;
  int get jumlahFasilitas => _jumlahFasilitas;
  set jumlahFasilitas(int value) {
    _jumlahFasilitas = value;
    notifyListeners();
  }

  int idStudio = 0;

  editStudio(String namaStudio, String alamat, String deskripsi) {
    allStudio.firstWhere((element) => element.id == idStudio).nama = namaStudio;
    allStudio.firstWhere((element) => element.id == idStudio).alamat = alamat;
    allStudio.firstWhere((element) => element.id == idStudio).deskripsi =
        deskripsi;
    print(allStudio.firstWhere((element) => element.id == idStudio).nama);
  }

  // Data Studio Penyedia
  List<Studios> _myStudio = [];
  List<Studios> get myStudio => _myStudio;
  set myStudio(List<Studios> value) {
    _myStudio = value;
    notifyListeners();
  }

  List<File> _imageStudio = [];
  List<File> get imageStudio => _imageStudio;
  set imageStudio(List<File> value) {
    _imageStudio = value;
    notifyListeners();
  }

  // method mengambil past image
  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      //_image = File(pickedFile.path);
      _imageStudio.add(File(pickedFile.path));
      counter += 1;
      print(_imageStudio);
    } else {
      print('No image selected.');
    }
  }

  // MENAMBAHKAN DATA STUDIO
  postDataStudio(var data, BuildContext context) async {
    var res = await Network().postData(data, '/studio/create');
    var body = jsonDecode(res.body);
    if (body['success']) {
      int studioId = body['data']['id'];

      if (_imageStudio.isEmpty) {
        print(_imageStudio);
      } else {
        for (int i = 0; i < _imageStudio.length; i++) {
          Map<String, String> dataImage = {
            'studio_id': body['data']['id'].toString()
          };
          Network()
              .addImage(dataImage, _imageStudio[i].path, '/studio/image/add');
          print('ok');
        }
        //_fetchData(context);
      }

      //Navigator.pushNamed(context, KelolaStudio.routeName);
    } else {
      Navigator.pushNamed(context, TambahDataStudio.routeName);
    }
  }

  // GET DATA STUDIO
  getDataStudio(BuildContext context, String link) async {
    var res = await Network().getData('/studio/show');
    var body = jsonDecode(res.body);
    print(body);

    if (body['success']) {
      //print(_studioPenyedia);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, link);
      print(body);
    } else {
      Navigator.pushNamed(context, TambahDataStudio.routeName);
    }
  }

  List<Studios> _studioPenyedia = [
    //Studios(1, 'unknow', 'unknow', 'unknow', 0, 0, 0, 0, [])
  ];
  List<Studios> get studioPenyedia => _studioPenyedia;
  set studioPenyedia(List<Studios> value) {
    _studioPenyedia = value;
    notifyListeners();
  }

  // GET DATA STUDIO
  List<String> _image = [
    'https://www.dauhpurikangin.id/uploads/default/noimages.png'
  ];

  List<String> get image => _image;
  set image(List<String> value) {
    _image = value;
    notifyListeners();
  }

  getData(BuildContext context) async {
    var res = await Network().getData('/studio/show');
    var body = jsonDecode(res.body);
    var imageData = body['image_data'].toList();
    print(imageData);

    if (body['success']) {
      List<String> gambar = image;
      List<int> idImage = [0];
      if (imageData.isNotEmpty) {
        gambar = List.generate(
            imageData.length, (index) => url + imageData[index]['image']);
        idImage =
            List.generate(imageData.length, (index) => imageData[index]['id']);
      }
      _studioPenyedia = [
        Studios(
          body['data']['id'],
          body['data']['nama_studio'],
          body['data']['alamat'],
          body['data']['deskripsi'],
          body['data']['rating'] * 1.0,
          0,
          body['data']['tarif_minimal'],
          body['data']['tarif_maksimal'],
          gambar,
          idImage,
          body['data']['status_tempat'],
          body['data']['status_transaksi'],
        )
      ];
      _detailStudio = Studios(
        body['data']['id'],
        body['data']['nama_studio'],
        body['data']['alamat'],
        body['data']['deskripsi'],
        body['data']['rating'] * 1.0,
        0,
        body['data']['tarif_minimal'],
        body['data']['tarif_maksimal'],
        body['image_data'].toList().isNotEmpty
            ? List.generate(body['image_data'].toList().length,
                (index) => url + body['image_data'].toList()[index]['image'])
            : image,
        [0],
        body['data']['status_tempat'],
        body['data']['status_transaksi'],
      );
      _dataRuang = List.generate(
          body['fasilitas'].length,
          (index) => Ruang(
              id: body['fasilitas'][index]['id'],
              idStudio: body['fasilitas'][index]['studio_id'],
              nama: body['fasilitas'][index]['nama_fasilitas'],
              tarif: body['fasilitas'][index]['tarif']));
      _jadwal = List.generate(
          body['jadwal'].length,
          (index) => Jadwal(
              body['jadwal'][index]['id'],
              body['jadwal'][index]['studio_id'],
              body['jadwal'][index]['nama_hari'],
              body['jadwal'][index]['jam_buka'],
              body['jadwal'][index]['jam_tutup'],
              body['jadwal'][index]['status'] == 0 ? false : true));
      print(body);
      // Navigator.pushReplacementNamed(context, KelolaStudio.routeName);
    } else {}
  }

  // UPDATE DATA STUDIO
  updateStudio(var data, BuildContext context) async {
    var res = await Network().putData(data, '/studio/update');
    var body = jsonDecode(res.body);
    print(body['data']['id']);
    if (_imageStudio.isEmpty) {
      print('data poto' + _imageStudio.toString());
    } else {
      print('data poto' + _imageStudio.toString());
      for (int i = 0; i < _imageStudio.length; i++) {
        Map<String, String> dataImage = {
          'studio_id': body['data']['id'].toString()
        };
        Network()
            .addImage(dataImage, _imageStudio[i].path, '/studio/image/add');
        print('ok');
      }
    }
  }

  deleteImage(int id, BuildContext context) async {
    var res = await Network().getData('/studio/image/delete/${id}');
    var body = jsonDecode(res.body);
    _fetchData(context);
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
    await Future.delayed(const Duration(seconds: 2));

    // Close the dialog programmatically
    Navigator.of(context).pop();
    //getDataStudio(context, '/kelolaStudio');
    counter += 1;
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  String _cari = '';
  String get cari => _cari;
  set cari(String value) {
    _cari = value;
    notifyListeners();
  }

  // Image Studio
  pencarian(String pencari) {
    _cari = pencari;
    _allStudio = _myStudio
        .where((element) =>
            element.nama.toLowerCase().contains(_cari.toLowerCase()))
        .toList();
  }
}
