import 'package:bookio2/models/ruang.dart';
import 'package:bookio2/page/penyedia/KelolaRuangStudio.dart';
import 'package:bookio2/provider/RuangProvider.dart';
import 'package:bookio2/widget/penyedia/ModalsEditRuang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListRuang extends StatelessWidget {
  int index;
  ListRuang({required this.index});

  @override
  Widget build(BuildContext context) {
    final dataRuang = Provider.of<RuangProvider>(context);
    // ALERT //! PESAN KONFIRMASI Hapus
    PesanKonfirmasiHapus(BuildContext context, List<Ruang> data) {
      Widget okButton = Container(
        width: 100,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
            onPressed: () {
              var id = dataRuang.ruangPenyedia[index].id;
              dataRuang.deleteDataFasilitas(id, context);
              Navigator.pop(context);
            },
            child: Text('Ya')),
      );
      Widget cancelButton = Container(
        width: 100,
        child: ElevatedButton(
            key: UniqueKey(),
            style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Batal')),
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: Text(
          "Perhatian",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("Hapus data...?"),
        actions: [
          cancelButton,
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

    return Column(
      key: UniqueKey(),
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black38),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataRuang.ruangPenyedia[index].nama,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0)
                                .format(dataRuang.ruangPenyedia[index].tarif),
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                          Text(" /Jam")
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      ModalsEditRuang(
                              index: index, data: dataRuang.ruangPenyedia)
                          .modalsEditRuang(context);
                      //print(dataRuang.ruangPenyedia[index]);
                    },
                    child: Icon(
                      Icons.edit_note_sharp,
                      size: 36,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      print(dataRuang.ruangPenyedia[index].nama);
                      PesanKonfirmasiHapus(context, dataRuang.ruangPenyedia);
                      // var id = dataRuang.ruangPenyedia[index].id;
                      // dataRuang.deleteDataFasilitas(id);
                    },
                    child: Icon(
                      Icons.cancel,
                      size: 36,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

void _fetchData(BuildContext context) async {
  // show the loading dialog
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Loading...')
              ],
            ),
          ),
        );
      });

  // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
  await Future.delayed(const Duration(seconds: 1));

  // Close the dialog programmatically
  Navigator.of(context).pop();

  Navigator.pushNamed(context, KelolaRuangStudio.routeName);
}
