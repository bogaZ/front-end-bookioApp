import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingCard extends StatelessWidget {
  String nama;
  double rating;
  String tanggal;

  RatingCard({required this.nama, required this.rating, required this.tanggal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(50),
              ),
              width: 50,
              height: 50,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    children: [
                      RatingBarIndicator(
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        direction: Axis.horizontal,
                        rating: rating,
                        unratedColor: Color(0xFF9E9E9E),
                        itemCount: 5,
                        itemSize: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(rating.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      Text(tanggal,
                          style: TextStyle(
                            color: Colors.black38,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
