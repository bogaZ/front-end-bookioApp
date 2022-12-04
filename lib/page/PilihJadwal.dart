import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:bookio2/services/PilihJadwalServices.dart';
import '../widget/ButtonPembayaran.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widget/kalender.dart';
import '../widget/GridRuang.dart';
import '../widget/GridJam.dart';
import '../provider/StudioProvider.dart';

class PilihJadwal extends StatefulWidget {
  static const nameRoute = "/pilihJadwal";

  @override
  State<PilihJadwal> createState() => _PilihJadwalState();
}

class _PilihJadwalState extends State<PilihJadwal> {
  late PageController controller;

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

  @override
  Widget build(BuildContext context) {
    // MENERIMA //!ID DARI STUDIO YANG DIPILIH
    StudioProvider studioProvider =
        ModalRoute.of(context)!.settings.arguments as StudioProvider;

    final idStudio = studioProvider.detailStudio.id;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudioProvider()),
        ChangeNotifierProvider(create: (context) => PilihJadwalServices()),
        ChangeNotifierProvider(
            create: (context) => PilihJadwalProvider(
                idStudio: idStudio,
                studioProvider: studioProvider,
                context: context)),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text('Pilih Jadwal'),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: MediaQuery.of(context).size.width >= 768
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child:
                                        // KALENDER //!APLIKASI
                                        // CONSUMER //!KALENDER KalenderProvider

                                        KalenderBookio(
                                      idStudio: idStudio,
                                    )),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Text(
                                            'Tempat',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        PemilihanTempat(),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 10),
                                          child: Text(
                                            'Waktu',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // PEMILIHAN //!JAM

                                        PemilihanJam(),
                                      ],
                                    )),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // KALENDER //!APLIKASI
                                // CONSUMER //!KALENDER KalenderProvider

                                KalenderBookio(idStudio: idStudio),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Text(
                                    'Tempat',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // PEMILIHAN //!TEMPAT
                                PemilihanTempat(),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 10),
                                  child: Text(
                                    'Waktu',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // PEMILIHAN //!JAM
                                PemilihanJam(),
                              ],
                            ),
                    ),
                  ),
                ),
                ButtonPembayaran()
              ],
            )),
      ),
    );
  }
}
