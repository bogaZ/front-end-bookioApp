import 'package:bookio2/page/PilihJadwal.dart';
import 'package:bookio2/page/SemuaUlasan.dart';
import 'package:bookio2/provider/JadwalProvider.dart';
import '../widget/jadwal_left.dart';
import 'package:bookio2/provider/RuangProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/widget/rating_card.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import '../provider/StudioProvider.dart';
import '../provider/RatingProvider.dart';
import '../widget/jadwal_right.dart';

class DetailStudio extends StatefulWidget {
  static const nameRoute = "/detailStudio";
  const DetailStudio({Key? key}) : super(key: key);

  @override
  _DetailStudioState createState() => _DetailStudioState();
}

class _DetailStudioState extends State<DetailStudio> {
  late PageController controller;

  GlobalKey<PageContainerState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    // MENGAMBIL //!ID DARI STUDIO YANG DIPILIH
    final idStudio = ModalRoute.of(context)!.settings.arguments as String;

    // // PROVIDER //! DATA STUDIO
    // final studio = Provider.of<StudioProvider>(context)
    //     .allStudio
    //     .firstWhere((element) => element.id.toString() == idStudio);

    // // PROVIDER //! DATA RATING
    // //? Berdasarkan idSTudio yang didapat
    // final myrating = Provider.of<RatingProvider>(context)
    //     .dataRating
    //     .where((element) => element.idStudio == idStudio);

    // // PROVIDER //! DATA RUANG
    // //? Berdasarkan idSTudio yang didapat
    // final ruangStudio = Provider.of<RuangProvider>(context)
    //     .dataRuang
    //     .where((element) => element.idStudio == idStudio)
    //     .toList();

    // // PROVIDER //! JADWAL STUDIO
    // //? Data jadwal berdasarkan idStudio
    // final jadwal = Provider.of<JadwalProvider>(context);
    // final dataJadwal = jadwal.dataJadwal
    //     .where((element) => element.idStudio == idStudio)
    //     .toList();

    final int mobileS = 320;
    final int mobileM = 375;
    final int mobileL = 425;
    final int tablet = 768;
    final int laptopM = 1024;
    final int laptopL = 1440;
    final LebarLayar = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => StudioProvider()),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text('Detail Tempat'),
          ),
          body: Consumer<StudioProvider>(builder: (context, studioProvider, _) {
            return FutureBuilder(
                future: studioProvider.getDetailStudio(int.parse(idStudio)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.black26,
                        child: Container(
                          height: 250.0,
                          child: PageIndicatorContainer(
                            key: key,
                            indicatorSelectorColor: Colors.deepOrange,
                            child: PageView(
                              children: List.generate(
                                studioProvider.detailStudio.image.length,
                                (index) => Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(studioProvider
                                              .detailStudio.image[index]),
                                          fit: BoxFit.cover)),
                                ),
                              ),

                              controller: controller,
                              //reverse: true,
                            ),
                            align: IndicatorAlign.bottom,
                            length: studioProvider.detailStudio.image.length,
                            indicatorSpace: 10.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  studioProvider.detailStudio.nama,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Row(
                                    children: [
                                      Text('Jumlah Ruang Dimiliki : '),
                                      Text(
                                        studioProvider.jumlahFasilitas
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black26,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 10),
                                  child: Text(
                                    studioProvider.detailStudio.deskripsi,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: LebarLayar >= tablet
                                      ? double.infinity
                                      : 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 50,
                                  child: TabBar(
                                      labelColor: Colors.black,
                                      indicatorWeight: 5,
                                      indicatorColor: Colors.deepOrange,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      //indicatorSize: TabBarIndicatorSize.label,
                                      //isScrollable: true,
                                      labelPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 10, 0),
                                      //indicatorPadding: EdgeInsets.all(10),
                                      tabs: [
                                        Container(
                                          height: 30,
                                          //width: 110,
                                          child: Text('Jam Operasional'),
                                        ),
                                        // Container(
                                        //   //width: 120,
                                        //   height: 30,
                                        //   child: Text('Peringkat & Ulasan'),
                                        // ),
                                        Container(
                                          //width: 50,
                                          height: 30,
                                          child: Text('Alamat Studio'),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          child: TabBarView(children: [
                            Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                //color: Colors.red,
                                child: LebarLayar <= mobileS
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Jadwal1(
                                            data: studioProvider.jadwal,
                                          ),
                                          Jadwal2(
                                            data: studioProvider.jadwal,
                                          )
                                        ],
                                      )
                                    : LebarLayar <= mobileL
                                        ? Row(
                                            children: [
                                              Jadwal1(
                                                data: studioProvider.jadwal,
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Jadwal2(
                                                  data: studioProvider.jadwal),
                                            ],
                                          )
                                        : Center(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Jadwal1(
                                                    data: studioProvider.jadwal,
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Jadwal2(
                                                      data: studioProvider
                                                          .jadwal),
                                                ],
                                              ),
                                            ),
                                          )),
                            // myrating.isNotEmpty
                            //     ? ListView(children: [
                            //         RatingCard(
                            //             nama: myrating.last.nama,
                            //             rating: myrating.last.rating,
                            //             tanggal: myrating.last.tanggal),
                            //         InkWell(
                            //           onTap: () {
                            //             Navigator.pushNamed(
                            //                 context, SemuaUlasan.routeName,
                            //                 arguments: idStudio);
                            //           },
                            //           child: Text(
                            //               "Lihat semua ulasan (${myrating.length})",
                            //               style:
                            //                   TextStyle(color: Colors.black54)),
                            //         )
                            //       ])
                            //     :

                            //SizedBox(),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(studioProvider.detailStudio.alamat),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 50,
                              width:
                                  LebarLayar <= mobileL ? double.infinity : 400,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    PilihJadwal.nameRoute,
                                    arguments: studioProvider,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrange, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                child: Text(
                                  'Pilih Jadwal',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
        ),
      ),
    );
  }
}
