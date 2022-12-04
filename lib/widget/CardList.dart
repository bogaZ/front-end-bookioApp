import 'package:bookio2/page/DetailPemesanan.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  // CardList({
  //   Key? key,

  // }) : super(key: key);
  CardList({
    required this.image,
    required this.tanggal,
    required this.idPemesanan,
    required this.invoice,
    required this.namaTempat,
    required this.status,
    required this.dedline,
  });

  String image;
  DateTime tanggal;
  int idPemesanan;
  String invoice;
  String namaTempat;
  String status;
  DateTime dedline;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPemesanan.routeName,
            arguments: invoice);
        //print(invoice);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
            child: Container(
              width: 500,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((tanggal.day < 10
                              ? '0' + tanggal.day.toString()
                              : tanggal.day.toString()) +
                          '/' +
                          (tanggal.month < 10
                              ? '0' + tanggal.month.toString()
                              : tanggal.month.toString()) +
                          '/' +
                          tanggal.year.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Id Pemesanan : ',
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        invoice,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        namaTempat,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'Status : ',
                            style: TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            DateTime.now().isAfter(dedline) &&
                                    status == 'Menunggu Pembayaran'
                                ? 'Kadaluarsa'
                                : DateTime.now().isAfter(dedline) &&
                                        status == 'Dibatalkan'
                                    ? 'Kadaluarsa'
                                    : status,
                            style: TextStyle(
                                color: status == 'Menunggu Pembayaran' ||
                                        status == 'Kadaluarsa' ||
                                        status == 'Dibatalkan'
                                    ? Colors.red
                                    : status == 'Menunggu Konfirmasi'
                                        ? Colors.blue
                                        : Colors.green,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
