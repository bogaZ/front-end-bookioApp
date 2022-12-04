import 'package:bookio2/alert/BookingDiterima.dart';
import 'package:bookio2/models/Pemesanan.dart';
import 'package:bookio2/page/Pembayaran.dart';
import 'package:bookio2/page/penyedia/PemesananLangsung.dart';
import 'package:bookio2/provider/PemesananProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/provider/penyedia/PemesananLangsungProvider.dart';
import 'package:bookio2/services/PilihJadwalServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/PilihJadwalProvider.dart';

class ModalsPopupPenyedia {
  String idStudio;
  dynamic identitas;
  PilihJadwalProvider data;
  BuildContext context;
  ModalsPopupPenyedia(
      {required this.idStudio,
      required this.identitas,
      required this.context,
      required this.data});

  onButton() {
    showModalBottomSheet(
        isScrollControlled: true,
        //enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        context: context,
        constraints: BoxConstraints(),
        builder: (context) {
          // final dataPemesanan = Provider.of<PemesananLangsungProvider>(context);
          // final dataUser = Provider.of<UserProvider>(context).dataUser;
          // final dataStudio =
          //     Provider.of<StudioProvider>(context).allStudio.firstWhere(
          //           (element) => element.id.toString() == idStudio,
          //         );
          final dataStudio = data.studioProvider.studioPenyedia.first;
          print(dataStudio.nama);
          return Container(
            //height: 700,
            width: 500,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataStudio.nama,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    dataStudio.alamat,
                    style: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Ruang',
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: data.tampungRuangDipesan
                                    .map((e) => Text("${e["namaRuang"]}"))
                                    .toList()),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Total Durasi',
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                            Row(
                              children: [
                                Text(data.totalDuration.toString()),
                                Text(' Jam'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal',
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                            Text(data.tanggalDipilih
                                .toString()
                                .substring(0, 10)),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jam',
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: data.tampungRuangDipesan
                                      .map((e) => Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text("${e["jamAwal"]}"),
                                              Text(' - '),
                                              Text(e["jamAkhir"] == "24:00"
                                                  ? "00:00"
                                                  : "${e["jamAkhir"]}")
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Rincian Biaya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: data.tampungRuangDipesan
                              .map((e) => Text(
                                  "Sewa ${e["namaRuang"]} (${int.parse(e['jamAkhir'].toString().substring(0, 2)) - int.parse(e['jamAwal'].toString().substring(0, 2))} Jam)"))
                              .toList(),
                        ),
                        Column(
                          children: data.tampungRuangDipesan
                              .map((e) => Text(NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(e["tarif"])))
                              .toList(),
                        )
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Total '),
                          Text(
                            '(Harga sudah termasuk PPN)',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black26,
                            ),
                          )
                        ],
                      ),
                      Text(NumberFormat.currency(
                              locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                          .format(data.totalPembayaran))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Identitas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama',
                                style: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              Text(identitas['nama']),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No Hp',
                                style: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              Text(identitas['nomer_hp'])
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              // dataPemesanan.dataPemesanan.add(Pemesanan(
                              //     idPemesanan: "null",
                              //     kodeTransaksi: "KodeSementara",
                              //     idUser: "null",
                              //     namaUser: data.namaUser,
                              //     nomerHp: data.nomerHp,
                              //     idStudio: idStudio,
                              //     namaStudio: dataStudio.nama,
                              //     tanggal: data.tanggalDipilih
                              //         .toString()
                              //         .substring(0, 10),
                              //     totalDurasi: data.totalDuration,
                              //     totalPembayaran: data.totalPembayaran,
                              //     status: "Menunggu Pembayaran"));
                              // Navigator.pushNamed(
                              //     context, PemesananLangsung.routeName);
                              var dataPemesanan = {
                                "nama_user": identitas['nama'],
                                "nomor_hp": identitas['nomer_hp'],
                                "studio_id":
                                    data.studioProvider.detailStudio.id,
                                "tanggal": data.tanggalDipilih
                                    .toString()
                                    .substring(0, 10),
                                "fasilitas_dipesan": List.generate(
                                    data.tampungRuangDipesan.length,
                                    (index) => {
                                          "fasilitas_id":
                                              data.tampungRuangDipesan[index]
                                                  ['idRuang'],
                                          "jam_awal":
                                              data.tampungRuangDipesan[index]
                                                  ['jamAwal'],
                                          "jam_akhir":
                                              data.tampungRuangDipesan[index]
                                                  ['jamAkhir'],
                                          "durasi": int.parse(data
                                                  .tampungRuangDipesan[index]
                                                      ['jamAkhir']
                                                  .toString()
                                                  .substring(0, 2)) -
                                              int.parse(data
                                                  .tampungRuangDipesan[index]
                                                      ['jamAwal']
                                                  .toString()
                                                  .substring(0, 2))
                                        })
                              };

                              PilihJadwalServices()
                                  .addPemesananPenyedia(dataPemesanan, context);
                              print(dataPemesanan);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                            ),
                            child: Text('Lanjut')),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
