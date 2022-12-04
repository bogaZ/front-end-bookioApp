import 'package:flutter/material.dart';

class MaksimalPemesanan {
  int nilai;
  MaksimalPemesanan({required this.nilai});

  maksimalPemesanan(BuildContext context) {
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
      //title: Text("bookio"),
      title: Text(
        'Perhatian',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: Text("Maksimal Pemesanan " + nilai.toString() + " Jam"),
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
