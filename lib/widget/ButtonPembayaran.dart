// import 'package:bookio2/provider/StudioProvider.dart';
// ignore_for_file: file_names

import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/widget/ModalsPopup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/PilihJadwalProvider.dart';
import 'package:provider/provider.dart';

class ButtonPembayaran extends StatelessWidget {
  const ButtonPembayaran({super.key});

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    final data = Provider.of<PilihJadwalProvider>(context);
    // final mydata = data.tampungRuangDipesan;
    final idStudio = data.idStudio;
    // final dataStudio = data.studioProvider.detailStudio;

    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Durasi '),
                      Text(
                        data.totalDuration.toString(),
                        style: const TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Total '),
                      Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                            .format(data.totalPembayaran),
                        style: const TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width:
                  400, //(MediaQuery.of(context).size.width >= 768)? 400 : double.infinity ,
              child: Consumer<PilihJadwalProvider>(
                builder: (context, pilihJadwalProvider, _) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: pilihJadwalProvider.totalDuration == 0
                        ? null
                        : () {
                            pilihJadwalProvider.namaUser =
                                dataUser.userData['name'];
                            pilihJadwalProvider.nomerHp =
                                dataUser.userData['nomor_hp'];
                            // RETURN //!ONBUTTON
                            ModalsPopup(
                                    idStudio: idStudio.toString(),
                                    data: data,
                                    context: context)
                                .onButton();
                          },
                    child: const Text(
                      "Bayar",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
