import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices with ChangeNotifier {
  bool _data = false;
  bool get data => _data;
  set data(bool value) {
    _data = value;
    notifyListeners();
  }

  File _image = File('null');
  File get image => _image;
  set image(File value) {
    _image = value;
    notifyListeners();
  }

  // method mengambil past image
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(_image);
      _data = true;
      counter += 1;
      print(_data);
    } else {
      print('No image selected.');
    }
  }

  // Upload Bukti pembayaran
  uploadBuktiPembayaran(
      Map<String, String> data, String filepath, BuildContext context) async {
    Network().addImage(data, filepath, '/pemesanan/upload/buktipembayaran');
    Navigator.pushNamed(context, '/navbar');
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
