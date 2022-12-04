import 'dart:convert';

import 'package:bookio2/models/WithdrawModels.dart';
import 'package:bookio2/page/penyedia/TambahWithdraw.dart';
import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/provider/penyedia/WithdrawProvider.dart';
import 'package:bookio2/services/RekeningService.dart';
import 'package:bookio2/services/WithdrawServices.dart';
import 'package:bookio2/services/api.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widget/penyedia/ListWithdraw.dart';

import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  static const routeName = "/withdraw";

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final dataWithdraw = Provider.of<WithdrawProvider>(context, listen: false);
    final rekeningService =
        Provider.of<RekeningService>(context, listen: false);
    final datawithdrawServices =
        Provider.of<WithdrawServices>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, BottomNavbarPenyedia.nameRoute);
        Provider.of<RekeningService>(context, listen: false);
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WithdrawServices()),
          ChangeNotifierProvider(create: (context) => RekeningService()),
          ChangeNotifierProvider(create: (context) => RekeningProvider()),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, BottomNavbarPenyedia.nameRoute);
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.deepOrange,
            title: Text("Penarikan Saldo"),
          ),
          body: Consumer<WithdrawServices>(
            builder: (context, withdrawServices, _) => RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                withdrawServices.counter += 1;
              },
              color: Colors.deepOrange,
              child: FutureBuilder(
                future: withdrawServices.getDataWithdraw(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.wallet_rounded,
                                    color: Colors.black45),
                                SizedBox(
                                  width: 5,
                                ),
                                FutureBuilder(
                                    future: rekeningService.getDataRekening(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.deepOrange),
                                        );
                                      }
                                      return Consumer<RekeningProvider>(
                                        builder: (context, rekeningProvider,
                                                _) =>
                                            FutureBuilder(
                                                future: rekeningProvider
                                                    .getDataRekening(
                                                        rekeningService
                                                            .dataRekening),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Colors
                                                                  .deepOrange),
                                                    );
                                                  }
                                                  return Text(
                                                    NumberFormat.currency(
                                                            locale: 'id',
                                                            symbol: 'Rp. ',
                                                            decimalDigits: 0)
                                                        .format(rekeningProvider
                                                            .tampungSaldo),
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  );
                                                }),
                                      );
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, TambahWithdraw.routeName);
                                dataWithdraw.totalJumlah = 0;
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tambah Withdraw',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "Melakukan penarikan saldo",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black26),
                                      )
                                    ],
                                  ),

                                  leading: Icon(
                                    Icons.add_circle,
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
                              height: 20,
                            ),
                            Text(
                              "Transaksi Terakhir",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                      Consumer<WithdrawProvider>(
                        builder: (context, withdrawProvider, _) =>
                            FutureBuilder(
                                future: withdrawProvider.getDataWithdraw(
                                    withdrawServices.dataWithdraw),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.deepOrange),
                                    );
                                  }
                                  return Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 20),
                                        child: ListView.builder(
                                            itemCount: dataWithdraw
                                                .dataWithdraw.length,
                                            itemBuilder: (context, i) {
                                              return Column(
                                                children: [
                                                  ListWithdraw(
                                                    index: i,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              );
                                            })),
                                  );
                                }),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
