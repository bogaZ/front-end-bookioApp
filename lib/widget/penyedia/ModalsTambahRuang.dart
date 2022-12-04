import 'package:bookio2/page/penyedia/KelolaRuangStudio.dart';
import 'package:bookio2/provider/RuangProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ModalsTambahRuang {
  pupUpModals(BuildContext context) {
    final namaRuang = TextEditingController();
    final tarif = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Tambah Ruang Studio",
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
                      controller: namaRuang,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama ruang harus diisi!';
                        }
                        return null;
                      },
                      autofocus: true,
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
                      //autofocus: true,
                      controller: tarif,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tarif ruang harus diisi!';
                        }
                        return null;
                      },
                      obscureText: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                                  onPressed: () {
                                    // ruangProvider.counter += 1;
                                    // ruangProvider.tambahRuang(
                                    //     namaRuang.text, int.parse(tarif.text));
                                    // Navigator.pop(context);
                                    var data = {
                                      'nama_fasilitas': namaRuang.text,
                                      'tarif': tarif.text,
                                    };
                                    if (_formKey.currentState!.validate()) {
                                      ruangProvider.postDataRuang(
                                          data, context);
                                      _fetchData(context);
                                    }
                                  },
                                  child: Text("Simpan")),
                        ),
                      )),
                ],
              ),
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
    await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    Navigator.of(context).pop();
    //getDataStudio(context, '/kelolaStudio');
    Navigator.pushNamed(context, KelolaRuangStudio.routeName);
  }
}
