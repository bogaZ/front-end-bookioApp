import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:bookio2/widget/ModalsPopup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/PilihJadwalProvider.dart';
import 'package:provider/provider.dart';

class ButtonPembayaran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    final data = Provider.of<PilihJadwalProvider>(context);
    final mydata = data.tampungRuangDipesan;
    final idStudio = data.idStudio;
    final dataStudio = data.studioProvider.detailStudio;

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Durasi '),
                        Text(
                          data.totalDuration.toString(),
                          style: TextStyle(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Total '),
                        Text(
                          NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0)
                              .format(data.totalPembayaran),
                          style: TextStyle(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width:
                    400, //(MediaQuery.of(context).size.width >= 768)? 400 : double.infinity ,
                child: Consumer<PilihJadwalProvider>(
                  builder: (context, pilihJadwalProvider, _) => ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepOrange),
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
                      child: Text(
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
      ),
    );
  }
}
