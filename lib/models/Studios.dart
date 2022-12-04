import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/models/ruang.dart';
import 'package:flutter/material.dart';

class Studios {
  int id;
  String nama;
  String alamat;
  String deskripsi;
  double rating;
  int jumlah;
  int tarifMinimal;
  int tarifMaksimal;
  List<String> image;
  List<int> idImage;
  String StatusTempat;
  String StatusTransaksi;

  Studios(
    this.id,
    this.nama,
    this.alamat,
    this.deskripsi,
    this.rating,
    this.jumlah,
    this.tarifMinimal,
    this.tarifMaksimal,
    this.image,
    this.idImage,
    this.StatusTempat,
    this.StatusTransaksi,
  );
}
