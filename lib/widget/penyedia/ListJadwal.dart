import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/provider/penyedia/DropDownProvider.dart';
import 'package:bookio2/provider/JadwalProvider.dart';
import 'package:bookio2/services/JadwalServices.dart';
import 'package:bookio2/widget/penyedia/ModalsEditJadwal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../page/penyedia/KelolaJadwal.dart';
import 'DropDownJamAkhir.dart';
import 'DropDownJamAwal.dart';

class ListJadwal extends StatelessWidget {
  int index;
  JadwalProvider dataJadwal;
  ListJadwal({
    required this.index,
    required this.dataJadwal,
  });

  @override
  Widget build(BuildContext context) {
    final dataDropDown = Provider.of<DropDownProvider>(context);
    final jadwalServices = Provider.of<JadwalServices>(context);

    modalEditJadwal(BuildContext context) {
      dataJadwal.tampungJamAwal = [dataJadwal.jadwalPenyedia[index].jamBuka];
      dataJadwal.tampungJamAkhir = [dataJadwal.jadwalPenyedia[index].jamTutup];
      dataDropDown.cekJamAwal(dataJadwal.jadwalPenyedia[index].jamBuka);
      dataDropDown.cekJamAkhir(dataJadwal.jadwalPenyedia[index].jamTutup);

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
                    dataJadwal.jadwalPenyedia[index].hari == "Monday"
                        ? "Edit Data Senin"
                        : dataJadwal.jadwalPenyedia[index].hari == "Tuesday"
                            ? "Edit Data Selasa"
                            : dataJadwal.jadwalPenyedia[index].hari ==
                                    "Wednesday"
                                ? "Edit Data Rabu"
                                : dataJadwal.jadwalPenyedia[index].hari ==
                                        "Thursday"
                                    ? "Edit Data Kamis"
                                    : dataJadwal.jadwalPenyedia[index].hari ==
                                            "Friday"
                                        ? "Edit Data Jum'at"
                                        : dataJadwal.jadwalPenyedia[index]
                                                    .hari ==
                                                "Saturday"
                                            ? "Edit Data Sabtu"
                                            : "Edit Data Minggu",
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
                          DropDownJamAwal(
                            index: index,
                            dataJadwal: dataJadwal,
                            dataJamAwal: dataDropDown.myJamAwal,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jam Tutup"),
                          SizedBox(
                            height: 5,
                          ),
                          DropDownJamAkhir(
                            index: index,
                            dataJadwal: dataJadwal,
                            dataJamAkhir: dataDropDown.myJamAkhir,
                          ),
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
                          builder: (context, jadwalProvider, _) =>
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.deepOrange),
                                  onPressed: () {
                                    // print(jadwalProvider.tampungJamAwal);
                                    // jadwalProvider.updateJadwal(index);
                                    // Navigator.pop(context);
                                    // print(jadwalProvider.tampungJamAwal);
                                    // print(jadwalProvider.tampungJamAkhir);

                                    var data = {
                                      "jam_buka":
                                          dataJadwal.tampungJamAwal.first,
                                      "jam_tutup":
                                          dataJadwal.tampungJamAkhir.first,
                                      "status": true
                                    };
                                    print(data);
                                    var id =
                                        dataJadwal.jadwalPenyedia[index].id;
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

    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.black38)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    dataJadwal.jadwalPenyedia[index].hari == "Monday"
                        ? "Senin"
                        : dataJadwal.jadwalPenyedia[index].hari == "Tuesday"
                            ? "Selasa"
                            : dataJadwal.jadwalPenyedia[index].hari ==
                                    "Wednesday"
                                ? "Rabu"
                                : dataJadwal.jadwalPenyedia[index].hari ==
                                        "Thursday"
                                    ? "Kamis"
                                    : dataJadwal.jadwalPenyedia[index].hari ==
                                            "Friday"
                                        ? "Jum'at"
                                        : dataJadwal.jadwalPenyedia[index]
                                                    .hari ==
                                                "Saturday"
                                            ? "Sabtu"
                                            : "Minggu",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    dataJadwal.jadwalPenyedia[index].jamBuka +
                        " - " +
                        dataJadwal.jadwalPenyedia[index].jamTutup,
                    style: TextStyle(
                      color: !dataJadwal.jadwalPenyedia[index].status
                          ? Colors.black38
                          : Colors.deepOrange,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: !dataJadwal.jadwalPenyedia[index].status
                        ? null
                        : () {
                            modalEditJadwal(context);
                          },
                    child: Icon(
                      Icons.edit_note_sharp,
                      size: 36,
                      color: !dataJadwal.jadwalPenyedia[index].status
                          ? Colors.black38
                          : Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                    activeColor: Colors.deepOrange,
                    value: dataJadwal.jadwalPenyedia[index].status,
                    onChanged: (newValue) {
                      int id = dataJadwal.jadwalPenyedia[index].id;
                      var data = {
                        "jam_buka": dataJadwal.jadwalPenyedia[index].jamBuka,
                        "jam_tutup": dataJadwal.jadwalPenyedia[index].jamTutup,
                        "status": newValue
                      };

                      jadwalServices.aktifJadwal(data, id);
                      dataJadwal.jadwalPenyedia[index].status = newValue;
                      dataJadwal.counter += 1;
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
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
