import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class ButtonJam extends StatelessWidget {
  final int index;
  const ButtonJam({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Consumer<PilihJadwalProvider>(
      builder: (context, pilihJadwalProvider, _) => InkWell(
        key: ObjectKey(index),
        onTap: !pilihJadwalProvider.cekTanggal(index) ||
                !pilihJadwalProvider.cekJadwal(index) ||
                pilihJadwalProvider.dataRuang.isEmpty ||
                !pilihJadwalProvider.sudahDipesan(index)
            ? null
            : () {
                pilihJadwalProvider.counter = 0;
                pilihJadwalProvider.tabJam(index);
                pilihJadwalProvider.printData();
              },
        child: pilihJadwalProvider.dataRuang.isEmpty
            ? null
            : Ink(
                key: ObjectKey(index),
                width: 100,
                decoration: BoxDecoration(
                  // jika kondisi jadwal tutup
                  color: pilihJadwalProvider
                          .listOfJam[pilihJadwalProvider.indexRuang][index]
                      ? Colors.deepOrange
                      : !pilihJadwalProvider.cekTanggal(index) ||
                              !pilihJadwalProvider.sudahDipesan(index)
                          ? Colors.black26
                          : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pilihJadwalProvider.dataJam[index].namaJam,
                      style: TextStyle(
                        // jika kondisi jadwal tutup
                        color: !pilihJadwalProvider.cekTanggal(index) ||
                                !pilihJadwalProvider.sudahDipesan(index)
                            ? Colors.white
                            : !pilihJadwalProvider.cekJadwal(index)
                                ? Colors.black26
                                : pilihJadwalProvider.listOfJam[
                                        pilihJadwalProvider.indexRuang][index]
                                    ? Colors.white
                                    : Colors.black,
                      ),
                    ),
                    !pilihJadwalProvider.cekJadwal(index)
                        ? const Text("")
                        : Text(
                            "${"${pilihJadwalProvider.dataRuang[pilihJadwalProvider.indexRuang].tarif}".substring(0, pilihJadwalProvider.dataRuang[pilihJadwalProvider.indexRuang].tarif.toString().length - 3)}K",
                            style: TextStyle(
                              color: !pilihJadwalProvider.cekTanggal(index) ||
                                      !pilihJadwalProvider.sudahDipesan(index)
                                  ? Colors.white
                                  : !pilihJadwalProvider.cekJadwal(index)
                                      ? Colors.black26
                                      : pilihJadwalProvider.listOfJam[
                                              pilihJadwalProvider
                                                  .indexRuang][index]
                                          ? Colors.white
                                          : Colors.black26,
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
