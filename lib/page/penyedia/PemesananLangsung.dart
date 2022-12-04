import 'package:bookio2/page/penyedia/TambahPemesanan.dart';
import 'package:bookio2/provider/PemesananProvider.dart';

import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/penyedia/PemesananLangsungProvider.dart';

import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:bookio2/widget/penyedia/CardList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PemesananLangsung extends StatelessWidget {
  static const routeName = "/pemesananLangsung";

  @override
  Widget build(BuildContext context) {
    // String idStudio = "0";
    // final data = Provider.of<PemesananLangsungProvider>(context);
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
          ChangeNotifierProvider(create: (context) => StudioProvider()),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              BottomNavbarPenyedia(argument: 1))));
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.deepOrange,
            title: Text("Pemesanan Langsung"),
          ),
          body: Consumer<StudioProvider>(builder: (context, studioProvider, _) {
            return FutureBuilder(
                future: studioProvider.getData(context),
                builder: (context, snapshot) {
                  return Consumer<PemesananProvider>(
                      builder: (context, pemesananProvider, _) {
                    return FutureBuilder(
                        future:
                            pemesananProvider.getPemesananPenyediaLangsung(),
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, TambahPemesanan.routeName,
                                        arguments: studioProvider);
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
                                            'Tambah Pemesanan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "Menambah data pemesanan",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black26),
                                          )
                                        ],
                                      ),

                                      leading: Icon(
                                        Icons.note_add_outlined,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 0),
                                child: Container(
                                  child: TabBarView(children: [
                                    RefreshIndicator(
                                      color: Colors.deepOrange,
                                      onRefresh: () async {
                                        pemesananProvider.counter += 1;
                                      },
                                      child: ListView(
                                          children: List.generate(
                                              pemesananProvider
                                                  .dataPemesanan.length,
                                              (index) => CardListPenyedia(
                                                  id: pemesananProvider
                                                      .dataPemesanan[index].id,
                                                  image: pemesananProvider
                                                      .imageStudio,
                                                  tanggal: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .tanggal,
                                                  invoice: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .invoice,
                                                  nama: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .namaUser,
                                                  namaStudio: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .namaStudio,
                                                  status: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .status,
                                                  dedline: pemesananProvider
                                                      .dataPemesanan[index]
                                                      .dedline))),
                                    ),
                                    ListView(
                                      children: [
                                        //  Text("Masih Kosong"),
                                      ],
                                    ),
                                  ]),
                                ),
                              )),
                            ],
                          );
                        });
                  });
                });
          }),
        ),
      ),
    );
  }
}
