import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/provider/penyedia/WithdrawProvider.dart';
import 'package:bookio2/services/RekeningService.dart';
import 'package:bookio2/services/WithdrawServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailWithdraw extends StatelessWidget {
  static const routeName = "/detailWithdraw";
  const DetailWithdraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WithdrawServices()),
        ChangeNotifierProvider(create: (context) => RekeningService()),
      ],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              "Detail Withdraw",
            ),
          ),
          body:
              Consumer<RekeningService>(builder: (context, rekeningService, _) {
            return Consumer<WithdrawServices>(
                builder: (context, withdrawServices, _) {
              return FutureBuilder(
                  future: rekeningService.getDataRekening(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            CircularProgressIndicator(color: Colors.deepOrange),
                      );
                    }
                    return FutureBuilder(
                        future: withdrawServices.getDataWithdraw(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.deepOrange),
                            );
                          }
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Penarikan Saldo",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(withdrawServices
                                              .dataWithdraw[index].nominal),
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text("Status : "),
                                        Text(
                                          withdrawServices
                                              .dataWithdraw[index].status,
                                          style: TextStyle(
                                            color: withdrawServices
                                                        .dataWithdraw[index]
                                                        .status !=
                                                    'Berhasil Dikonfirmasi'
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.black38,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.home_work_outlined,
                                          color: Colors.deepOrange,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "No. Rekening : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(rekeningService
                                                    .dataRekening
                                                    .first
                                                    .nomorRekening),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Nama Bank : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(rekeningService
                                                    .dataRekening
                                                    .first
                                                    .namaBank),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Nama Pemilik : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(rekeningService
                                                    .dataRekening
                                                    .first
                                                    .namaPemilik),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Color.fromARGB(31, 121, 121, 121),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Note : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        textAlign: TextAlign.justify,
                                        "Kami akan segera melakukan transfer ke nomer rekening anda dan segera melakukan konfirmasi withdraw atau penarikan saldo sesuai dengan nominal ang anda berikan",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  });
            });
          })),
    );
  }
}
