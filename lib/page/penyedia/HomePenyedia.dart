import 'dart:convert';
import 'package:bookio2/page/penyedia/CekTransaksi.dart';
import 'package:bookio2/page/penyedia/KelolaJadwal.dart';
import 'package:bookio2/page/penyedia/KelolaStudio.dart';
import 'package:bookio2/page/penyedia/NotofikasiPenyedia.dart';
import 'package:bookio2/page/penyedia/Withdraw.dart';
import 'package:bookio2/page/penyedia/loading/WithdrwawLoading.dart';
import 'package:bookio2/provider/NotifikasiProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/provider/penyedia/WithdrawProvider.dart';
import 'package:bookio2/services/RekeningService.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePenyedia extends StatefulWidget {
  const HomePenyedia({Key? key}) : super(key: key);

  @override
  State<HomePenyedia> createState() => _HomePenyediaState();
}

class _HomePenyediaState extends State<HomePenyedia> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  var userData;

  @override
  Widget build(BuildContext context) {
    final rekeningService =
        Provider.of<RekeningService>(context, listen: false);
    final dataNotifikasi = Provider.of<NotifikasiProvider>(context);
    final data = dataNotifikasi.dataNotifikasi
        .where((element) => element.status == false)
        .toList();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RekeningService()),
        ChangeNotifierProvider(create: (context) => RekeningProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => StudioProvider()),
      ],
      child: Scaffold(
          body: Consumer<RekeningService>(
        builder: (context, rekeningService, _) => RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              rekeningService.counter += 1;
              //dataRekening.getDataRekening();
            },
            child: FutureBuilder(
                future: rekeningService.getDataRekening(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  return Consumer<RekeningProvider>(
                    builder: (context, rekeningProvider, _) => FutureBuilder(
                        future: rekeningProvider
                            .getDataRekening(rekeningService.dataRekening),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxHeight: double.infinity,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 0, 20, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'bookio',
                                                  style: TextStyle(
                                                    color: Colors.transparent,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 32,
                                                  ),
                                                ),
                                                // Container(
                                                //   width: 105,
                                                //   height: 5,
                                                //   decoration: BoxDecoration(
                                                //     color: Colors.white,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            // Badge(
                                            //   badgeContent: Text(
                                            //     data
                                            //         .where((element) =>
                                            //             element.status == false)
                                            //         .toList()
                                            //         .length
                                            //         .toString(),
                                            //     style: TextStyle(
                                            //       color: Colors.deepOrange,
                                            //       fontWeight: FontWeight.bold,
                                            //     ),
                                            //   ),
                                            //   showBadge: data
                                            //               .where((element) =>
                                            //                   element.status ==
                                            //                   false)
                                            //               .toList()
                                            //               .length ==
                                            //           0
                                            //       ? false
                                            //       : true,
                                            //   shape: BadgeShape.circle,
                                            //   badgeColor: Colors.white,
                                            //   elevation: 4,
                                            //   padding:
                                            //       const EdgeInsetsDirectional
                                            //           .fromSTEB(8, 8, 8, 8),
                                            //   position: BadgePosition.topEnd(),
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       dataNotifikasi.counter += 1;

                                            //       Navigator.pushNamed(
                                            //           context,
                                            //           NotifikasiPenyedia
                                            //               .routeName);
                                            //       data.forEach((element) {
                                            //         element.status = true;
                                            //       });
                                            //     },
                                            //     child: Icon(
                                            //       Icons.notifications,
                                            //       size: 32,
                                            //       color: Colors.white,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 30, 15, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Consumer<UserProvider>(builder:
                                                (context, userProvider, _) {
                                              return FutureBuilder(
                                                  future: userProvider
                                                      .getUserInfo(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Colors
                                                                    .deepOrange),
                                                      );
                                                    }
                                                    return Text(
                                                      userProvider
                                                          .userData['name'],
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    );
                                                  });
                                            }),
                                            Text(
                                              'Kelola studio musikmu dengan bookio',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.wallet_rounded,
                                                          color: Colors.white),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        NumberFormat.currency(
                                                                locale: 'id',
                                                                symbol: 'Rp. ',
                                                                decimalDigits:
                                                                    0)
                                                            .format(
                                                                rekeningProvider
                                                                    .tampungSaldo),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Saldo bookio pay",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ListView(
                                  children: [
                                    Column(
                                      children: [
                                        Consumer<StudioProvider>(
                                          builder:
                                              (context, studioProvider, _) =>
                                                  InkWell(
                                            onTap: () {
                                              // studioProvider.getDataStudio(
                                              //     context, '/kelolaStudio');
                                              // Navigator.pushNamed(context,
                                              //     KelolaStudio.routeName);
                                              studioProvider.getDataStudio(
                                                  context, '/kelolaStudio');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: null,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Kelola Studio',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Text(
                                                      "Mengelola studio musik",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.black26),
                                                    )
                                                  ],
                                                ),

                                                leading: Icon(
                                                  Icons.library_music_outlined,
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
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<StudioProvider>(
                                          builder:
                                              (context, studioProvider, _) =>
                                                  InkWell(
                                            onTap: () {
                                              studioProvider.getDataStudio(
                                                  context, '/kelolaJadwal');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: null,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Kelola Jadwal',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Text(
                                                      "Mengelola jadwal studio",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.black26),
                                                    )
                                                  ],
                                                ),

                                                leading: Icon(
                                                  Icons.calendar_month,
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
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                CekTransaksi.routeNmae);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: null,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Transaksi & Keuangan',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                  ),
                                                  Text(
                                                    "Mengecek transaksi tersimpan",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black26),
                                                  )
                                                ],
                                              ),

                                              leading: Icon(
                                                Icons.content_paste,
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
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            //withdrawProvider.getDataWithdraw(context);

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => WithdrawLoading()));
                                            Navigator.pushNamed(
                                                context, Withdraw.routeName);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: null,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Withdraw',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                  ),
                                                  Text(
                                                    "Melakukan penarikan tunai",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black26),
                                                  )
                                                ],
                                              ),

                                              leading: Icon(
                                                Icons.attach_money_outlined,
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
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          );
                        }),
                  );
                })),
      )),
    );
  }
}
