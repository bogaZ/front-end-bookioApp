import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:bookio2/widget/button_ruang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TAMPILAN //!PEMILIHA TEMPAT
class PemilihanTempat extends StatelessWidget {
  const PemilihanTempat({super.key});

  @override
  Widget build(BuildContext context) {
    //final data = Provider.of<PilihJadwalProvider>(context);
    //int banyakRuang = data.dataRuang.length;
    return Consumer<PilihJadwalProvider>(
      builder: (context, pilihJadwalProvider, _) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 4 / 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: pilihJadwalProvider.dataRuang.length,
              itemBuilder: (context, index) {
                return ButtonRuang(
                  index: index,
                );
              })),
    );
  }
}
