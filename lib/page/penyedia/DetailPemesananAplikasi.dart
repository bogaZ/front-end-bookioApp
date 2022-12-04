import 'package:bookio2/page/BeriUlasan.dart';
import 'package:bookio2/page/Pembayaran.dart';
import 'package:bookio2/provider/PemesananProvider.dart';
import 'package:bookio2/widget/TimerPemesanan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPemesananMelaluiAplikasi extends StatelessWidget {
  static const routeName = "/DetailPemesananMelaluiAplikasi";
  const DetailPemesananMelaluiAplikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PemesananProvider()),
      ],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text("Detail Pemesanan"),
          ),
          body: Consumer<PemesananProvider>(
              builder: (context, pemesananProvider, _) {
            return FutureBuilder(
                future: pemesananProvider.getDetailPemesananPenyedia(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      pemesananProvider.counter += 1;
                    },
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Identitas",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Colors.black26,
                                              ),
                                              Text(
                                                " Nama",
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            pemesananProvider
                                                .detailPemesanan.namaUser,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone_android,
                                                color: Colors.black26,
                                              ),
                                              Text(
                                                " No HP",
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            pemesananProvider
                                                .detailPemesanan.nomorHp,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    pemesananProvider
                                        .detailPemesanan.namaStudio,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.deepOrange,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          pemesananProvider
                                              .detailPemesanan.alamatStudio,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 160,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.credit_card_rounded,
                                                  color: Colors.black26,
                                                ),
                                                Text(
                                                  "ID Boking",
                                                  style: TextStyle(
                                                    color: Colors.black26,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              pemesananProvider
                                                  .detailPemesanan.invoice,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: Colors.black26,
                                              ),
                                              Text(
                                                "Tanggal",
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                pemesananProvider
                                                    .detailPemesanan.tanggal
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 160,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.format_list_bulleted,
                                                  color: Colors.black26,
                                                ),
                                                Text(
                                                  "Sewa Ruang",
                                                  style: TextStyle(
                                                    color: Colors.black26,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                pemesananProvider
                                                    .detailPemesanan
                                                    .fasilitasDipesan
                                                    .length,
                                                (index) => Text(
                                                  pemesananProvider
                                                          .detailPemesanan
                                                          .fasilitasDipesan[
                                                      index]['nama_fasilitas'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: Colors.black26,
                                              ),
                                              Text(
                                                "Durasi",
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: List.generate(
                                              pemesananProvider.detailPemesanan
                                                  .fasilitasDipesan.length,
                                              (index) => Text(
                                                "${pemesananProvider.detailPemesanan.fasilitasDipesan[index]['durasi']} Jam (${pemesananProvider.detailPemesanan.fasilitasDipesan[index]['jam_awal']}-${pemesananProvider.detailPemesanan.fasilitasDipesan[index]['jam_akhir']})",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 160,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .confirmation_num_outlined,
                                                  color: Colors.black26,
                                                ),
                                                Text(
                                                  "Status",
                                                  style: TextStyle(
                                                    color: Colors.black26,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              pemesananProvider.detailPemesanan
                                                              .status ==
                                                          'Menunggu Pembayaran' &&
                                                      DateTime.now().isAfter(
                                                          pemesananProvider
                                                              .detailPemesanan
                                                              .dedline)
                                                  ? 'Kadaluarsa'
                                                  : pemesananProvider
                                                      .detailPemesanan.status,
                                              style: TextStyle(
                                                color: pemesananProvider
                                                            .detailPemesanan
                                                            .status !=
                                                        'Berhasil Dipesan'
                                                    ? pemesananProvider
                                                                .detailPemesanan
                                                                .status !=
                                                            'Menunggu Konfirmasi'
                                                        ? Colors.red
                                                        : Colors.blue
                                                    : Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Rincian Biaya",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                            pemesananProvider.detailPemesanan
                                                .fasilitasDipesan.length,
                                            (index) => Text(
                                              pemesananProvider.detailPemesanan
                                                      .fasilitasDipesan[index]
                                                  ['nama_fasilitas'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                          )),
                                      Column(
                                        children: List.generate(
                                          pemesananProvider.detailPemesanan
                                              .fasilitasDipesan.length,
                                          (index) => Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp. ',
                                                    decimalDigits: 0)
                                                .format(pemesananProvider
                                                        .detailPemesanan
                                                        .fasilitasDipesan[index]
                                                    ['total']),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Total "),
                                          Text(
                                            "(Harga sudah termasuk PPN)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp. ',
                                                decimalDigits: 0)
                                            .format(pemesananProvider
                                                .detailPemesanan
                                                .totalPembayaran),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Text(
                                  //   "Customer Service",
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 18,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: 160,
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Icon(
                                  //             Icons.phone,
                                  //             color: Colors.black26,
                                  //           ),
                                  //           Text(
                                  //             "089766544322",
                                  //             style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Icon(
                                  //           Icons.email,
                                  //           color: Colors.black26,
                                  //         ),
                                  //         Text(
                                  //           "bookio@gmail.com",
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: Colors.black,
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Text(
                                  //   "Metode Pembayaran",
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Icon(Icons.monetization_on_outlined),
                                  //     Text(" BNI Transfer")
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          })),
    );
  }
}
