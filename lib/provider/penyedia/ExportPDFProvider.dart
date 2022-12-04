import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:bookio2/models/TransaksiModels.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class ExportPDFProvider with ChangeNotifier {
  List<TransaksiModels> dataTransaksi = [];
  ExportPDFProvider({required this.dataTransaksi});

  DateTime _dateAwal = DateTime.now();
  DateTime get dateAwal => _dateAwal;
  set dateAwal(DateTime value) {
    _dateAwal = value;
    notifyListeners();
  }

  DateTime _dateAkhir = DateTime.now();
  DateTime get dateAkhir => _dateAkhir;
  set dateAkhir(DateTime value) {
    _dateAkhir = value;
    notifyListeners();
  }

  getDataExport() async {
    List<TransaksiModels> data = dataTransaksi
        .where((element) => (element.tanggal.isAfter(_dateAwal) &&
            element.tanggal.isBefore(_dateAkhir.add(Duration(days: 1)))))
        .toList();
    int total = 0;
    int pembayaran = 0;
    int biayaAdmin = 0;
    for (int i = 0; i < data.length; i++) {
      total += data[i].totalPemasukan;
      pembayaran += data[i].totalPembayaran;
      biayaAdmin += data[i].totalBiayaAdmin;
    }

    final pdf = pw.Document();

    final headers = [
      'ID Transaksi',
      'Nama',
      'Pembayaran',
      '-5%',
      'Pemasukan',
      'Tanggal'
    ];

    final myData = data
        .map((e) => [
              e.invoice,
              e.namaPenyewa,
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(
                e.totalPembayaran,
              ),
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(
                e.totalBiayaAdmin,
              ),
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(
                e.totalPemasukan,
              ),
              e.tanggal.toString().substring(0, 10),
            ])
        .toList();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text('Laporan Transaksi & Keuangan',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(dateAwal.toString().substring(0, 10),
                            style:
                                pw.TextStyle(fontStyle: pw.FontStyle.italic)),
                        pw.Text(' s/d ',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(dateAkhir.toString().substring(0, 10),
                            style:
                                pw.TextStyle(fontStyle: pw.FontStyle.italic)),
                      ]),
                ]),
            pw.SizedBox(
              height: 50,
            ),
            pw.Table.fromTextArray(
              headers: headers,
              data: myData,
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Container(
                width: 120,
                child: pw.Text('Total Pembayaran',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ),
              pw.Text(' : ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(pembayaran))
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Container(
                width: 120,
                child: pw.Text('Total Biaya Admin',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ),
              pw.Text(' : ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(biayaAdmin))
            ]),
            pw.Divider(height: 1),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Container(
                width: 120,
                child: pw.Text('Total Pemasukan',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ),
              pw.Text(' : ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(total))
            ]),
          ];
        }));

    // pdf.addPage(
    //   pw.MultiPage(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return [
    //         pw.Column(
    //             crossAxisAlignment: pw.CrossAxisAlignment.center,
    //             children: [
    //               pw.Text('Laporan Pemasukan Keuangan',
    //                   textAlign: pw.TextAlign.center,
    //                   style: pw.TextStyle(
    //                     fontWeight: pw.FontWeight.bold,
    //                   )),
    //               pw.SizedBox(
    //                 height: 50,
    //               ),
    //               pw.Row(
    //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     pw.Column(
    //                         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                         children: List.generate(data.length, (index) {
    //                           return index == 0
    //                               ? pw.Column(
    //                                   crossAxisAlignment:
    //                                       pw.CrossAxisAlignment.start,
    //                                   children: [
    //                                       pw.Text('Id Transaksi'),
    //                                       pw.Text(data[index].invoice),
    //                                     ])
    //                               : pw.Text(data[index].invoice);
    //                         })),
    //                     pw.Column(
    //                         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                         children: List.generate(data.length, (index) {
    //                           return index == 0
    //                               ? pw.Column(
    //                                   crossAxisAlignment:
    //                                       pw.CrossAxisAlignment.start,
    //                                   children: [
    //                                       pw.Text('Nama'),
    //                                       pw.Text(data[index].namaPenyewa),
    //                                     ])
    //                               : pw.Text(data[index].namaPenyewa);
    //                         })),
    //                     pw.Column(
    //                         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                         children: List.generate(data.length, (index) {
    //                           return index == 0
    //                               ? pw.Column(
    //                                   crossAxisAlignment:
    //                                       pw.CrossAxisAlignment.start,
    //                                   children: [
    //                                       pw.Text('Tanggal'),
    //                                       pw.Text(data[index]
    //                                           .tanggal
    //                                           .toString()
    //                                           .substring(0, 10)),
    //                                     ])
    //                               : pw.Text(data[index]
    //                                   .tanggal
    //                                   .toString()
    //                                   .substring(0, 10));
    //                         })),
    //                     pw.Column(
    //                         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                         children: List.generate(data.length, (index) {
    //                           return index == 0
    //                               ? pw.Column(
    //                                   crossAxisAlignment:
    //                                       pw.CrossAxisAlignment.start,
    //                                   children: [
    //                                       pw.Text('Pembayaran'),
    //                                       pw.Text(NumberFormat.currency(
    //                                               locale: 'id',
    //                                               symbol: 'Rp. ',
    //                                               decimalDigits: 0)
    //                                           .format(
    //                                               data[index].totalPembayaran)),
    //                                     ])
    //                               : pw.Text(NumberFormat.currency(
    //                                       locale: 'id',
    //                                       symbol: 'Rp. ',
    //                                       decimalDigits: 0)
    //                                   .format(data[index].totalPembayaran));
    //                         })),
    //                     pw.Column(
    //                         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                         children: List.generate(data.length, (index) {
    //                           return index == 0
    //                               ? pw.Column(
    //                                   crossAxisAlignment:
    //                                       pw.CrossAxisAlignment.start,
    //                                   children: [
    //                                       pw.Text('- 5%'),
    //                                       pw.Text(NumberFormat.currency(
    //                                               locale: 'id',
    //                                               symbol: 'Rp. ',
    //                                               decimalDigits: 0)
    //                                           .format(
    //                                               data[index].totalBiayaAdmin)),
    //                                     ])
    //                               : pw.Text(NumberFormat.currency(
    //                                       locale: 'id',
    //                                       symbol: 'Rp. ',
    //                                       decimalDigits: 0)
    //                                   .format(data[index].totalBiayaAdmin));
    //                         })),
    //                     pw.Column(
    //                         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                         children: List.generate(data.length, (index) {
    //                           return index == 0
    //                               ? pw.Column(
    //                                   crossAxisAlignment:
    //                                       pw.CrossAxisAlignment.start,
    //                                   children: [
    //                                       pw.Text('Pemasukan'),
    //                                       pw.Text(NumberFormat.currency(
    //                                               locale: 'id',
    //                                               symbol: 'Rp. ',
    //                                               decimalDigits: 0)
    //                                           .format(
    //                                               data[index].totalPemasukan)),
    //                                     ])
    //                               : pw.Text(NumberFormat.currency(
    //                                       locale: 'id',
    //                                       symbol: 'Rp. ',
    //                                       decimalDigits: 0)
    //                                   .format(data[index].totalPemasukan));
    //                         })),
    //                   ]),
    //               pw.SizedBox(
    //                 height: 10,
    //               ),
    //               pw.Row(
    //                   mainAxisAlignment: pw.MainAxisAlignment.end,
    //                   children: [
    //                     pw.Text('Total Pemasukan : ',
    //                         style:
    //                             pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                     pw.Text(NumberFormat.currency(
    //                             locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
    //                         .format(total))
    //                   ]),
    //               pw.SizedBox(
    //                 height: 50,
    //               ),
    //               pw.Row(children: [
    //                 pw.Text('Periode : ',
    //                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 pw.Text(dateAwal.toString().substring(0, 10),
    //                     style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
    //                 pw.Text(' s/d ',
    //                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //                 pw.Text(dateAkhir.toString().substring(0, 10),
    //                     style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
    //               ]),
    //             ]),
    //       ]; // Center
    //     },
    //   ),
    // );

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/laporan_pemasukan.pdf');

    await file.writeAsBytes(bytes);

    // Page
    await OpenFile.open(file.path);
  }
}
