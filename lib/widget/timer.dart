import 'dart:async';
import 'package:flutter/material.dart';

@immutable
class TimerBookio extends StatefulWidget {
  const TimerBookio({Key? key}) : super(key: key);

  @override
  State<TimerBookio> createState() => _TimerBookioState();
}

class _TimerBookioState extends State<TimerBookio> {
  Duration endTimer = const Duration(seconds: 10);

  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        //print(endTimer);
        endTimer -= const Duration(seconds: 1);
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
      style: const TextStyle(fontSize: 18, color: Colors.white),
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
    Widget okButton = SizedBox(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok')),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      title: const Text(
        'Booking Omexo Studio Musik Banyuwangi',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: const Text(
          "Waktu upload bukti pembayaran habis pemesanan kadaluarsa"),
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
