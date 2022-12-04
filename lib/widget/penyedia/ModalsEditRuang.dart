import 'package:bookio2/models/ruang.dart';
import 'package:bookio2/page/penyedia/KelolaRuangStudio.dart';
import 'package:bookio2/provider/RuangProvider.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ModalsEditRuang {
  int index;
  final _formKey = GlobalKey<FormState>();
  List<Ruang> data;
  ModalsEditRuang({required this.index, required this.data});
  final namaRuang = TextEditingController();
  final tarif = TextEditingController();

  modalsEditRuang(BuildContext context) {
    namaRuang.text = data[index].nama;
    tarif.text = data[index].tarif.toString();
    showModalBottomSheet(
      isScrollControlled: true,
      //enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      constraints: BoxConstraints(),
      context: (context),
      builder: (context) => Container(
        width: 600,
        child: WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).unfocus();
            new TextEditingController().clear();
            // Close the dialog programmatically
            Navigator.pop(context);
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Container(
                height: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Edit Ruang Studio",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Nama Ruang Studio',
                        style: TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: TextFormField(
                        key: UniqueKey(),
                        controller: namaRuang,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama ruang harus diisi!';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Masukkan nama ruang studio',
                          hintStyle: TextStyle(
                            color: Colors.black12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Tarif /Jam',
                        style: TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: TextFormField(
                        key: UniqueKey(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autofocus: true,
                        controller: tarif,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tarif ruang harus diisi!';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixText: "Rp. ",
                          prefixIcon: Icon(
                            Icons.attach_money_outlined,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Masukkan tarif /Jam ruang',
                          hintStyle: TextStyle(
                            color: Colors.black12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        child: MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (context) => RuangProvider()),
                          ],
                          child: Consumer<RuangProvider>(
                            builder: (context, ruangProvider, _) =>
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepOrange,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var id = data[index].id;
                                        var myData = {
                                          "nama_fasilitas": namaRuang.text,
                                          "tarif": int.parse(tarif.text),
                                        };
                                        ruangProvider.updateDataFasilitas(
                                            myData, id, context);
                                      }

                                      FocusScope.of(context).unfocus();
                                      new TextEditingController().clear();
                                      // Close the dialog programmatically
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, KelolaRuangStudio.routeName);

                                      // ruangProvider.dataRuang
                                      //     .where((element) => element.idStudio == "0")
                                      //     .toList()[index]
                                      //     .nama = namaRuang.text;
                                      // ruangProvider.dataRuang
                                      //     .where((element) => element.idStudio == "0")
                                      //     .toList()[index]
                                      //     .tarif = int.parse(tarif.text);
                                    },
                                    child: Text("Update")),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  fetchData(BuildContext context) async {
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
    Navigator.pop(context);
    //getDataStudio(context, '/kelolaStudio');
  }
}
