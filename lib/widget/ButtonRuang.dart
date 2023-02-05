// ignore_for_file: file_names, must_be_immutable

import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonRuang extends StatelessWidget {
  int index;
  ButtonRuang({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Consumer<PilihJadwalProvider>(
      builder: (context, pilihJadwalProvider, _) => InkWell(
        onTap: () {
          pilihJadwalProvider.indexRuang = index;

          pilihJadwalProvider.tabRuang(index);
          pilihJadwalProvider.ambilIdRuang();
        },
        child: Ink(
          width: 100,
          decoration: BoxDecoration(
            color: pilihJadwalProvider.dataRuang[index].status
                //pilihJadwalProvider.dataRuang[index].status
                ? Colors.deepOrange
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pilihJadwalProvider.dataRuang[index].nama,
                // pilihJadwalProvider.dataRuang[index].nama,
                style: TextStyle(
                  color: pilihJadwalProvider.dataRuang[index].status
                      //pilihJadwalProvider.dataRuang[index].status
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
