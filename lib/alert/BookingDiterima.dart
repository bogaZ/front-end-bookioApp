import 'package:flutter/material.dart';

class BookingDiterima {
  BuildContext context;

  BookingDiterima({required this.context});
  bookingDiterima() {
    // set up the button
    Widget okButton = Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          onPressed: () => Navigator.pop(context),
          child: Text('Ok')),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      title: Text(
        'Perhatian',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: Text(
        "Segera selesaikan pembayaran & upload bukti pembayaran!",
        textAlign: TextAlign.justify,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
