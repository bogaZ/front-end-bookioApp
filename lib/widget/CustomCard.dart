import 'package:bookio2/page/DetailStudioPage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  //ini adalah konstruktor, saat class dipanggil parameter konstruktor wajib diisi
  //parameter ini akan mengisi title dan gambar pada setiap card
  CustomCard(
      {required this.id,
      required this.title,
      required this.image,
      required this.tarif,
      required this.rating,
      required this.jumlah});
  int id;
  String title;
  String image;
  int tarif;
  double rating;
  int jumlah;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // MELEMPAR //! ID STUDIO YANG DIPILIH
        Navigator.of(context)
            .pushNamed(DetailStudio.nameRoute, arguments: id.toString());
      },
      child: Card(
        //menambahkan bayangan
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tarif Mulai : ',
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(tarif),
                                  style: TextStyle(
                                    color: Colors.orange[800],
                                  ),
                                ),
                                Text(' / jam')
                              ],
                            ),
                          ),
                          // Padding(
                          //     padding: const EdgeInsetsDirectional.fromSTEB(
                          //         0, 10, 0, 0),
                          //     child: Row(
                          //       children: [
                          //         RatingBarIndicator(
                          //           itemBuilder: (context, index) => Icon(
                          //             Icons.star_rounded,
                          //             color: Colors.amber,
                          //           ),
                          //           direction: Axis.horizontal,
                          //           rating: rating,
                          //           unratedColor: Color(0xFF9E9E9E),
                          //           itemCount: 5,
                          //           itemSize: 20,
                          //         ),
                          //         Text(jumlah.toString(),
                          //             style: TextStyle(
                          //               fontSize: 14,
                          //             )),
                          //       ],
                          //     )),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
