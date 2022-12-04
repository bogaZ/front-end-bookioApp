import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/page/penyedia/KelolaJadwal.dart';
import 'package:bookio2/provider/penyedia/DropDownProvider.dart';
import 'package:bookio2/provider/JadwalProvider.dart';
import 'package:bookio2/services/JadwalServices.dart';
import 'package:bookio2/widget/penyedia/DropDownJamAkhir.dart';
import 'package:bookio2/widget/penyedia/DropDownJamAwal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalsEditJadwal {
  int index;
  DropDownProvider dataDropDown;
  ModalsEditJadwal({required this.dataDropDown, required this.index});
  modalEditJadwal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      //enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      constraints: BoxConstraints(),
      context: context,
      builder: (context) => Container(
        child: Consumer<JadwalProvider>(
          builder: (context, jadwalProvider, _) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  jadwalProvider.jadwalPenyedia[index].hari == "Monday"
                      ? "Edit Data Senin"
                      : jadwalProvider.jadwalPenyedia[index].hari == "Tuesday"
                          ? "Edit Data Selasa"
                          : jadwalProvider.jadwalPenyedia[index].hari ==
                                  "Wednesday"
                              ? "Edit Data Rabu"
                              : jadwalProvider.jadwalPenyedia[index].hari ==
                                      "Thursday"
                                  ? "Edit Data Kamis"
                                  : jadwalProvider.jadwalPenyedia[index].hari ==
                                          "Friday"
                                      ? "Edit Data Jum'at"
                                      : jadwalProvider
                                                  .jadwalPenyedia[index].hari ==
                                              "Saturday"
                                          ? "Edit Data Sabtu"
                                          : "Edit Data Sunday",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jam Buka"),
                        SizedBox(
                          height: 5,
                        ),
                        // DropDownJamAwal(
                        //   index: index,
                        //   dataJamAwal: dataDropDown.myJamAwal,
                        // ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jam Tutup"),
                        SizedBox(
                          height: 5,
                        ),
                        // DropDownJamAkhir(
                        //   index: index,
                        //   dataJamAkhir: dataDropDown.myJamAkhir,
                        // ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    child: Consumer<JadwalServices>(
                        builder: (context, jadwalServices, _) {
                      return Consumer<JadwalProvider>(
                        builder: (context, jadwalProvider, _) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrange),
                            onPressed: () {
                              // print(jadwalProvider.tampungJamAwal);
                              // jadwalProvider.updateJadwal(index);
                              // Navigator.pop(context);
                              // print(jadwalProvider.tampungJamAwal);
                              // print(jadwalProvider.tampungJamAkhir);

                              var data = {
                                "jam_buka": jadwalProvider.tampungJamAwal.first,
                                "jam_tutup":
                                    jadwalProvider.tampungJamAkhir.first,
                                "status": true
                              };

                              var id = jadwalProvider.jadwalPenyedia[index].id;
                              jadwalServices.updateJadwal(data, id);
                              _fetchData(context);
                              jadwalServices.counter += 1;
                            },
                            child: Text("Update")),
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
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
    await Future.delayed(const Duration(seconds: 2));

    // Close the dialog programmatically
    Navigator.of(context).pop();

    Navigator.pushNamed(context, KelolaJadwal.routeName);
  }
}
