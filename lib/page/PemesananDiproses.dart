import 'package:bookio2/provider/PemesananProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:provider/provider.dart';

import '../widget/CardList.dart';
import 'package:flutter/material.dart';

class PemesananDiproses extends StatefulWidget {
  PemesananDiproses({Key? key}) : super(key: key);

  @override
  _PemesananDiprosesState createState() => _PemesananDiprosesState();
}

class _PemesananDiprosesState extends State<PemesananDiproses> {
  List<Widget> Widgetsbookio = [];

  _PemesananDiprosesState() {
    // Widgetsbookio.add(CardList(
    //   image:
    //       'https://images.unsplash.com/photo-1598653222000-6b7b7a552625?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    //   tanggal: '17/02/2001',
    //   idPemesanan: 'L2R6786jundhkjh',
    //   namaTempat: 'OmexoStudio',
    //   status: 'Diproses',
    // ));
    // Widgetsbookio.add(CardList(
    //   image:
    //       'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    //   tanggal: '17/02/2001',
    //   idPemesanan: 'L2R6786jundhkjh',
    //   namaTempat: 'GreenStudio',
    //   status: 'Diproses',
    // ));
    // Widgetsbookio.add(CardList(
    //   image:
    //       'https://images.unsplash.com/photo-1559732277-7453b141e3a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    //   tanggal: '17/02/2001',
    //   idPemesanan: 'L2R6786jundhkjh',
    //   namaTempat: 'PrasastiStudio',
    //   status: 'Diproses',
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PemesananProvider()),
          ChangeNotifierProvider(create: (context) => StudioProvider()),
        ],
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepOrange,
            title: Text('Pemesanan'),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // child: Container(
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
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Container(
                    child: TabBarView(children: [
                      Consumer<StudioProvider>(
                          builder: (context, studioProvider, _) {
                        return RefreshIndicator(
                          color: Colors.deepOrange,
                          onRefresh: () async {
                            studioProvider.counter += 1;
                          },
                          child: FutureBuilder(
                              future: studioProvider.allDataStudio(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center();
                                }
                                return Consumer<PemesananProvider>(
                                  builder: (context, pemesananProvider, _) =>
                                      FutureBuilder(
                                          future: pemesananProvider
                                              .getDataPemesanan(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color:
                                                            Colors.deepOrange),
                                              );
                                            }
                                            return ListView.builder(
                                              itemCount: pemesananProvider
                                                  .dataPemesanan.length,
                                              itemBuilder: (context, index) {
                                                return CardList(
                                                  image: studioProvider
                                                      .allStudio
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          pemesananProvider
                                                              .dataPemesanan[
                                                                  index]
                                                              .idStudio)
                                                      .image
                                                      .first,
                                                  tanggal: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .tanggal,
                                                  idPemesanan: pemesananProvider
                                                      .dataPemesanan[index].id,
                                                  namaTempat: studioProvider
                                                      .allStudio
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          pemesananProvider
                                                              .dataPemesanan[
                                                                  index]
                                                              .idStudio)
                                                      .nama,
                                                  status: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .status,
                                                  invoice: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .invoice,
                                                  dedline: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .dedline,
                                                );
                                              },
                                              //children: Widgetsbookio,
                                            );
                                          }),
                                );
                              }),
                        );
                      }),
                      ListView(
                          // children: Widgetsbookio,
                          ),
                    ]),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
