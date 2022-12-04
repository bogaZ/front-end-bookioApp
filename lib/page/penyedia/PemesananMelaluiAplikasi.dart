import 'package:bookio2/widget/penyedia/CardListAplikasi.dart';
import 'package:flutter/material.dart';

import 'package:bookio2/provider/PemesananProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:provider/provider.dart';

class PemesananMelaluiAplikasi extends StatelessWidget {
  static const routeName = "/pemesananMelaluiAplikasi";
  const PemesananMelaluiAplikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String idStudio = "0";
    // final data = Provider.of<PemesananProvider>(context);
    // final dataPemesanan = data.dataPemesanan
    //     .where((element) => element.idStudio == idStudio)
    //     .toList();
    // final dataStudio = Provider.of<StudioProvider>(context)
    //     .allStudio
    //     .firstWhere((element) => element.id == int.parse(idStudio));
    return DefaultTabController(
      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PemesananProvider()),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text("Pemesanan melalui aplikasi"),
          ),
          body: Column(
            children: [
              // Container(
              //   width: 400,
              //   child: TabBar(
              //       indicatorColor: Colors.deepOrange,
              //       indicatorSize: TabBarIndicatorSize.label,
              //       indicatorWeight: 5,
              //       isScrollable: false,
              //       labelColor: Colors.black,
              //       tabs: [
              //         Container(
              //             alignment: Alignment.center,
              //             height: 35,
              //             child: Text('Diproses')),
              //         Container(
              //             alignment: Alignment.center,
              //             height: 35,
              //             child: Text('Riwayat')),
              //       ]),
              // ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Consumer<PemesananProvider>(
                    builder: (context, pemesananProvider, _) {
                  return FutureBuilder(
                      future: pemesananProvider.getPemesananPenyedia(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepOrange),
                          );
                        }
                        return Container(
                          child: TabBarView(children: [
                            RefreshIndicator(
                              color: Colors.deepOrange,
                              onRefresh: () async {
                                pemesananProvider.counter += 1;
                              },
                              child: ListView(
                                  children: List.generate(
                                      pemesananProvider.dataPemesanan.length,
                                      (index) =>
                                          CardListPenyediaMelaluiAplikasi(
                                            id: pemesananProvider
                                                .dataPemesanan[index].id,
                                            image:
                                                pemesananProvider.imageStudio,
                                            tanggal: pemesananProvider
                                                .dataPemesanan[index].tanggal,
                                            invoice: pemesananProvider
                                                .dataPemesanan[index].invoice,
                                            idUser: pemesananProvider
                                                .dataPemesanan[index].idUser,
                                            status: pemesananProvider
                                                .dataPemesanan[index].status,
                                            dedline: pemesananProvider
                                                .dataPemesanan[index].dedline,
                                          ))),
                            ),
                            ListView(
                              children: [
                                //Text("Masih Kosong"),
                              ],
                            ),
                          ]),
                        );
                      });
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
