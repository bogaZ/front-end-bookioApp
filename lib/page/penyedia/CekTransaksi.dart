import 'package:bookio2/models/TransaksiModels.dart';
import 'package:bookio2/provider/TransaksiProvider.dart';
import 'package:bookio2/provider/penyedia/ExportPDFProvider.dart';
import 'package:bookio2/widget/penyedia/ModalsExportTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CekTransaksi extends StatelessWidget {
  static const routeNmae = "/cekTransaksi";
  const CekTransaksi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransaksiProvider())
      ],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text("Transaksi & Keuangan"),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Consumer<TransaksiProvider>(
                      builder: (context, transaksiProvider, _) {
                    return InkWell(
                      onTap: () {
                        Export().modalExport(
                            context, transaksiProvider.dataTransaksi);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: null,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Export Ke PDF',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Text(
                                "Mengexport data ke PDF",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black26),
                              )
                            ],
                          ),

                          leading: Icon(
                            Icons.output_rounded,
                            color: Colors.deepOrange,
                            size: 30,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF303030),
                            size: 20,
                          ),
                          //tileColor: Colors.black26,
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Daftar Transaksi"),
                ),
                Expanded(
                    child: Container(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(child:
                          Consumer<TransaksiProvider>(
                              builder: (context, transaksiProvider, _) {
                        return FutureBuilder(
                            future: transaksiProvider.getTransaksi(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.deepOrange),
                                );
                              }
                              return DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'No',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'ID Transaksi',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Nama',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Tanggal',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Jenis Transaksi',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Total Pembayaran',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Biaya Admin / 5%',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Total Pemasukan',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                  transaksiProvider.dataTransaksi.length,
                                  (index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text((index + 1).toString())),
                                      DataCell(Text(transaksiProvider
                                          .dataTransaksi[index].invoice)),
                                      DataCell(Text(transaksiProvider
                                          .dataTransaksi[index].namaPenyewa)),
                                      DataCell(Text(transaksiProvider
                                          .dataTransaksi[index].tanggal
                                          .toString()
                                          .substring(0, 10))),
                                      DataCell(Text(transaksiProvider
                                          .dataTransaksi[index].jenis)),
                                      DataCell(Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp. ',
                                                decimalDigits: 0)
                                            .format(transaksiProvider
                                                .dataTransaksi[index]
                                                .totalPembayaran),
                                      )),
                                      DataCell(Text(NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(transaksiProvider
                                              .dataTransaksi[index]
                                              .totalBiayaAdmin))),
                                      DataCell(Text(NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(transaksiProvider
                                              .dataTransaksi[index]
                                              .totalPemasukan))),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }))),
                )),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }
}
