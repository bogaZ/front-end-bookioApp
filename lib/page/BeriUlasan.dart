import 'package:bookio2/alert/FeedBackUlasan.dart';
import 'package:bookio2/models/rating.dart';
import 'package:bookio2/page/DetailPemesanan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BeriUlasan {
  popupBeriUlasan(BuildContext context) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(),
      builder: (context) => Container(
        width: 600,
        height: 600,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Beri Ulasan Omexo Studio",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 40,
                    width: 400,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, DetailPemesanan.routeName);
                          Navigator.pop(FeedBackUlasan(context: context)
                              .ulasanFeedBack());
                        },
                        child: Text("Kirim Ulasan")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
