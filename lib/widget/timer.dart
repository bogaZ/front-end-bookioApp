import 'dart:async';

import 'package:flutter/material.dart';

class TimerBookio extends StatefulWidget {
  TimerBookio({Key? key}) : super(key: key);

  @override
  State<TimerBookio> createState() => _TimerBookioState();
}

class _TimerBookioState extends State<TimerBookio> {
  Duration endTimer = Duration(seconds: 10);

  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        //print(endTimer);
        endTimer -= Duration(seconds: 1);
        if (endTimer.inMinutes == 0 && endTimer.inSeconds == 0) {
          bookingDibatalkan(context);
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_doubleDigitParse(endTimer.inMinutes % 60)}: ${_doubleDigitParse(endTimer.inSeconds % 60)}",
      style: TextStyle(fontSize: 18, color: Colors.white),
    );
  }

  String _doubleDigitParse(int digit) {
    if (digit < 10) {
      return "0$digit";
    } else {
      return "$digit";
    }
  }

  bookingDibatalkan(BuildContext context) {
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
        'Booking Omexo Studio Musik Banyuwangi',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: Text("Waktu upload bukti pembayaran habis pemesanan kadaluarsa"),
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
