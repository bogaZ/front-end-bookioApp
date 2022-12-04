import 'dart:convert';

import 'package:bookio2/models/WithdrawModels.dart';
import 'package:bookio2/page/penyedia/Withdraw.dart';
import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/provider/penyedia/WithdrawProvider.dart';
import 'package:bookio2/services/RekeningService.dart';
import 'package:bookio2/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/WithdrawServices.dart';

class TambahWithdraw extends StatelessWidget {
  static const routeName = "/tambahWithdraw";
  const TambahWithdraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RekeningService>(builder: (context, rekeningService, _) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RekeningService()),
          ChangeNotifierProvider(create: (context) => RekeningProvider()),
          ChangeNotifierProvider(create: ((context) => WithdrawProvider())),
          ChangeNotifierProvider(create: (context) => WithdrawServices()),
        ],
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text("Tambah Withdraw"),
            ),
            body: FutureBuilder(
              future: rekeningService.getDataRekening(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange),
                  );
                }
                return Consumer<RekeningProvider>(
                    builder: (context, rekeningProvider, _) {
                  return FutureBuilder(
                      future: rekeningProvider
                          .getDataRekening(rekeningService.dataRekening),
                      builder: (context, snapshop) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepOrange),
                          );
                        }
                        return Consumer<WithdrawProvider>(
                          builder: (contxt, withdrawProvider, _) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Pilih Jumlah Withdraw "),
                                    Text(
                                      "(Rp)",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 3 / 2,
                                              mainAxisSpacing: 10.0,
                                              crossAxisSpacing: 10.0,
                                            ),
                                            itemCount: withdrawProvider
                                                .jumlahWithdraw.length,
                                            itemBuilder: (context, index) {
                                              return Consumer<RekeningProvider>(
                                                builder: (context,
                                                        rekeningProvider, _) =>
                                                    Consumer<WithdrawProvider>(
                                                  builder: (context,
                                                          withdrawProvider,
                                                          _) =>
                                                      InkWell(
                                                    onTap: () {
                                                      if (rekeningProvider
                                                                  .tampungSaldo !=
                                                              0 &&
                                                          rekeningProvider
                                                                  .tampungSaldo >=
                                                              withdrawProvider
                                                                      .jumlahWithdraw[
                                                                  index]) {
                                                        withdrawProvider
                                                                .totalJumlah =
                                                            withdrawProvider
                                                                    .jumlahWithdraw[
                                                                index];
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                        width: 1,
                                                        color: Colors.black38,
                                                      )),
                                                      child: Center(
                                                        child: Text(NumberFormat
                                                                .currency(
                                                                    locale:
                                                                        'id',
                                                                    symbol:
                                                                        'Rp. ',
                                                                    decimalDigits:
                                                                        0)
                                                            .format(withdrawProvider
                                                                    .jumlahWithdraw[
                                                                index])),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 3 / 2,
                                              mainAxisSpacing: 10.0,
                                              crossAxisSpacing: 10.0,
                                            ),
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              return Consumer<WithdrawProvider>(
                                                builder: (context,
                                                        withdrawProvider, _) =>
                                                    Consumer<RekeningProvider>(
                                                  builder: (context,
                                                          rekeningProvider,
                                                          _) =>
                                                      InkWell(
                                                    onTap: () {
                                                      withdrawProvider
                                                              .totalJumlah =
                                                          rekeningProvider
                                                              .tampungSaldo;
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                        width: 1,
                                                        color: Colors.black38,
                                                      )),
                                                      child: Center(
                                                        child: Text("Semua"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.black38,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("Total Jumlah "),
                                            Text(
                                              "(Rp)",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<WithdrawProvider>(
                                          builder:
                                              (context, withdrawProvider, _) =>
                                                  Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp. ',
                                                    decimalDigits: 0)
                                                .format(withdrawProvider
                                                    .totalJumlah),
                                            style: TextStyle(
                                              fontSize: 36,
                                              color: Colors.deepOrange,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.black38,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Saldo Dimiliki : ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<RekeningProvider>(
                                              builder: (context,
                                                      rekeningProvider, _) =>
                                                  Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp. ',
                                                        decimalDigits: 0)
                                                    .format(rekeningProvider
                                                        .tampungSaldo),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Penarikan : ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<WithdrawProvider>(
                                              builder: (context,
                                                      withdrawProvider, _) =>
                                                  Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp. ',
                                                        decimalDigits: 0)
                                                    .format(withdrawProvider
                                                        .totalJumlah),
                                                style: TextStyle(
                                                  color: Colors.deepOrange,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.black38,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Sisa Saldo : ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<WithdrawProvider>(
                                              builder: (context,
                                                      withdrawProvider, _) =>
                                                  Consumer<RekeningProvider>(
                                                builder: (context,
                                                        rekeningProvider, _) =>
                                                    Text(
                                                  NumberFormat.currency(
                                                          locale: 'id',
                                                          symbol: 'Rp. ',
                                                          decimalDigits: 0)
                                                      .format((rekeningProvider
                                                              .tampungSaldo -
                                                          withdrawProvider
                                                              .totalJumlah)),
                                                  style: TextStyle(
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Consumer<WithdrawServices>(
                                    builder: (context, withdrawServices, _) =>
                                        ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.deepOrange,
                                      ),
                                      onPressed: withdrawProvider.totalJumlah ==
                                              0
                                          ? null
                                          : () {
                                              _fetchData(context);
                                              var data = {
                                                'jumlah': withdrawProvider
                                                    .totalJumlah,
                                              };

                                              withdrawServices.requestWithdraw(
                                                  data, context);

                                              // data.dataWithdraw.add(WithdrawModels(
                                              //     tanggal:
                                              //         DateTime.now().toString().substring(0, 10),
                                              //     nominal: data.totalJumlah));
                                              //Navigator.pushNamed(context, Withdraw.routeName);

                                              // dataRekening.tampungSaldo -= data.totalJumlah;
                                              // data.totalJumlah = 0;
                                            },
                                      child: Text("Withdraw"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                });
              },
            )),
      );
    });
  }

  void _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 2));

    // Close the dialog programmatically
    Navigator.of(context).pop();

    Navigator.pushNamed(context, Withdraw.routeName);
  }
}
