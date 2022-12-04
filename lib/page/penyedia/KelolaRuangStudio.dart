import 'dart:io';

import 'package:bookio2/page/penyedia/DetailPemesanan.dart';
import 'package:bookio2/page/penyedia/KelolaStudio.dart';
import 'package:bookio2/provider/RuangProvider.dart';
import 'package:bookio2/widget/penyedia/ListRuang.dart';
import 'package:bookio2/widget/penyedia/ModalsEditRuang.dart';
import 'package:bookio2/widget/penyedia/ModalsTambahRuang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KelolaRuangStudio extends StatelessWidget {
  static const routeName = "/kelolaRuangStudio";
  const KelolaRuangStudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, KelolaStudio.routeName);
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RuangProvider()),
        ],
        child: WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).unfocus();
            new TextEditingController().clear();
            // Close the dialog programmatically
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, KelolaStudio.routeName);
                  },
                  icon: Icon(Icons.arrow_back_rounded),
                ),
                backgroundColor: Colors.deepOrange,
                title: Text("Kelola Ruang Studio"),
              ),
              body: Consumer<RuangProvider>(
                builder: (context, ruangProvider, _) => FutureBuilder(
                  future: ruangProvider.getDataRuang(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            CircularProgressIndicator(color: Colors.deepOrange),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        ruangProvider.counter += 1;
                      },
                      color: Colors.deepOrange,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 20, 20, 0),
                            child: Text("Jumlah Ruang Studio Dimiliki : "),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                ModalsTambahRuang().pupUpModals(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: null,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tambah Ruang',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "Menambah ruang studio musik",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black26),
                                      )
                                    ],
                                  ),

                                  leading: Icon(
                                    Icons.add_circle,
                                    color: Colors.deepOrange,
                                    size: 30,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF303030),
                                    size: 20,
                                  ),
                                  //tileColor: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 20, 0),
                              child: ListView.builder(
                                itemCount: ruangProvider.ruangPenyedia.length,
                                itemBuilder: (context, index) {
                                  return ListRuang(
                                    index: index,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
        ),
      ),
    );
  }
}
