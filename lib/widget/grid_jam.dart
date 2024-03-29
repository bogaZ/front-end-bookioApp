// import 'package:bookio2/provider/jam.dart';
import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:bookio2/services/PilihJadwalServices.dart';
import 'package:flutter/material.dart';
import 'button_jam.dart';
import 'package:provider/provider.dart';

// TAMPILAN //!PEMILIHAN JAM
class PemilihanJam extends StatelessWidget {
  const PemilihanJam({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PilihJadwalProvider>(context, listen: false);
    return Consumer<PilihJadwalServices>(
        builder: (context, pilihJadwalServices, _) {
      var myData = {"tanggal": data.tanggalDipilih.toString().substring(0, 10)};
      return FutureBuilder(
          future: pilihJadwalServices.getDataPemesanan(
              myData, data.studioProvider.detailStudio.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }
            return Consumer<PilihJadwalProvider>(
                builder: (context, pilihJadwalProvider, _) {
              return FutureBuilder(
                  future: pilihJadwalProvider
                      .getDataPemesanan(pilihJadwalServices.dataRuangDipesan),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Colors.deepOrange),
                      );
                    }
                    return Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Column(
                        children: [
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            ),
                            itemCount: 24,
                            itemBuilder: pilihJadwalProvider
                                    .dataRuang.isNotEmpty
                                ? (context, index) {
                                    return ChangeNotifierProvider(
                                      create: (context) =>
                                          pilihJadwalProvider.dataJam[index],
                                      child: ButtonJam(
                                        index: index,
                                      ),
                                    );
                                  }
                                : (context, index) => Container(),
                          ),
                        ],
                      ),
                    );
                  });
            });
          });
    });
  }
}
