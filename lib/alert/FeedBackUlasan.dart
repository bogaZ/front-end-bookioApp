import 'package:flutter/material.dart';

class FeedBackUlasan {
  BuildContext context;
  FeedBackUlasan({required this.context});
  // PESAN //!ALERT JIKA JAM YANG DIPILIH TIDAK BERURUTAN
  ulasanFeedBack() {
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
        'Pembaritahuan',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: Text("Terima kasih atas ulasan yang telah anda berikan.."),
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
