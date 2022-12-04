import 'package:bookio2/models/TransaksiModels.dart';
import 'package:bookio2/provider/penyedia/ExportPDFProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Export {
  modalExport(BuildContext context, List<TransaksiModels> dataTransaksi) {
    DateTime dateAwal = DateTime.now();
    showModalBottomSheet(
      isScrollControlled: true,
      //enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      constraints: BoxConstraints(),
      context: (context),
      builder: (context) => Container(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) =>
                      ExportPDFProvider(dataTransaksi: dataTransaksi)),
            ],
            child: Consumer<ExportPDFProvider>(
              builder: (context, exportPDFProvider, _) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Export Data Transaksi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "${exportPDFProvider.dateAwal.year}/${exportPDFProvider.dateAwal.month}/${exportPDFProvider.dateAwal.day}"),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? newData = await showDatePicker(
                                  context: context,
                                  initialDate: exportPDFProvider.dateAwal,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2024));
                              if (newData == null) {
                              } else {
                                exportPDFProvider.dateAwal = newData;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: Colors.black38)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Tanggal Awal"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "${exportPDFProvider.dateAkhir.year}/${exportPDFProvider.dateAkhir.month}/${exportPDFProvider.dateAkhir.day}"),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? newData = await showDatePicker(
                                  context: context,
                                  initialDate: exportPDFProvider.dateAkhir,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2024));
                              if (newData == null) {
                              } else {
                                exportPDFProvider.dateAkhir = newData;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: Colors.black38)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Tanggal Akhir"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                          ),
                          onPressed: () {
                            exportPDFProvider.getDataExport();
                          },
                          child: Text("Export")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
