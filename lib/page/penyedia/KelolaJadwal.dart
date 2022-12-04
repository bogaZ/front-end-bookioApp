import 'package:bookio2/provider/penyedia/DropDownProvider.dart';
import 'package:bookio2/provider/JadwalProvider.dart';
import 'package:bookio2/services/JadwalServices.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/penyedia/ListJadwal.dart';

class KelolaJadwal extends StatelessWidget {
  static const routeName = "/kelolaJadwal";
  const KelolaJadwal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool datatap = false;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => JadwalServices()),
        ChangeNotifierProvider(create: (context) => JadwalProvider()),
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, BottomNavbarPenyedia.nameRoute);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, BottomNavbarPenyedia.nameRoute);
                },
                icon: Icon(Icons.arrow_back_rounded)),
            backgroundColor: Colors.deepOrange,
            title: Text("Kelola Jadwal"),
          ),
          body: Consumer<JadwalServices>(builder: (context, jadwalServices, _) {
            return FutureBuilder(
                future: jadwalServices.getJadwal(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  return Consumer<JadwalProvider>(
                      builder: (context, jadwalProvider, _) {
                    return FutureBuilder(
                        future: jadwalProvider
                            .getDataJadwal(jadwalServices.jadwalPenyedia),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.deepOrange),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListView(
                                      children: List.generate(
                                    jadwalServices.jadwalPenyedia.length,
                                    (index) => ListJadwal(
                                      dataJadwal: jadwalProvider,
                                      index: index,
                                    ),
                                  )),
                                ),
                              ),
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
