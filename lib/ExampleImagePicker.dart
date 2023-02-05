// ignore_for_file: file_names

import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/api.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});
  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  Service service = Service();
  final _addFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late File _image = File('image');
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Images'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Card(
              child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text('Image Title'),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: _buildImage()),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (_addFormKey.currentState!.validate()) {
                        _addFormKey.currentState!.save();
                        var body = {'title': _titleController.text};
                        service.addImage(body, _image.path);
                      }
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // ignore: unnecessary_null_comparison
    if (_image == null) {
      return const Icon(
        Icons.add,
        color: Colors.grey,
      );
    } else {
      return Text(_image.path);
    }
  }
}
