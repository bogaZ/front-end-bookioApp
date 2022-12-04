import 'package:bookio2/models/Studios.dart';
import 'package:bookio2/page/penyedia/HomePenyedia.dart';
import 'package:bookio2/page/penyedia/KelolaStudio.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDataStudio extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const routeName = "/editStudio";
  final _formKey = GlobalKey<FormState>();
  final namaStudio = TextEditingController();
  final alamat = TextEditingController();
  final deskripsi = TextEditingController();
  final tarifMinimal = TextEditingController();
  final tarifMaksimal = TextEditingController();

  // ALERT //! PESAN KONFIRMASI

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudioProvider()),
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, KelolaStudio.routeName);
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(context, KelolaStudio.routeName);
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.deepOrange,
            title: Text("Edit Data Studio"),
          ),
          body: Consumer<StudioProvider>(
            builder: (context, studioProvider, _) {
              PesanKonfirmasi(BuildContext context, var data) {
                Widget okButton = Container(
                  width: 100,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepOrange),
                      onPressed: () {
                        studioProvider.updateStudio(data, context);
                        _fetchData(context);
                      },
                      child: Text('Simpan')),
                );

                Widget cancelButton = Container(
                  width: 100,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepOrange),
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
                  content: Text("Simpan perubahan..?"),
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

              return FutureBuilder(
                future: studioProvider.getData(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepOrange),
                    );
                  }
                  namaStudio.text = studioProvider.studioPenyedia.first.nama;
                  alamat.text = studioProvider.studioPenyedia.first.alamat;
                  tarifMinimal.text = studioProvider
                      .studioPenyedia.first.tarifMinimal
                      .toString();
                  tarifMaksimal.text = studioProvider
                      .studioPenyedia.first.tarifMaksimal
                      .toString();
                  deskripsi.text =
                      studioProvider.studioPenyedia.first.deskripsi;

                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Text(
                                      'Nama Studio',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      controller: namaStudio,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Nama studio harus diisi !';
                                        }
                                        return null;
                                      },

                                      //autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.home,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Masukkan nama studio',
                                        hintStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Text(
                                      'Alamat Studio',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      controller: alamat,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Alamat studio harus diisi !';
                                        }
                                        return null;
                                      },
                                      //autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Masukkan alamat studio',
                                        hintStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Text(
                                      'Deskripsi',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      controller: deskripsi,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Deskripsi studio harus diisi !';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      minLines: 1,
                                      maxLines: 5,
                                      //autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.description,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Masukkan deskripsi studio',
                                        hintStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Text(
                                      'Tarif Minimal',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      controller: tarifMinimal,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Tarif minimal harus diisi !';
                                        }
                                        return null;
                                      },
                                      //autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.monetization_on_outlined,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Masukkan tarif minimal',
                                        hintStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Text(
                                      'Tarif Maksimal',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      controller: tarifMaksimal,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Tarif maksimal harus diisi !';
                                        }
                                        return null;
                                      },
                                      //autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.monetization_on_outlined,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Masukkan tarif maksimal',
                                        hintStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      strokeWidth: 2,
                                      strokeCap: StrokeCap.square,
                                      color: Colors.black38,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 150,
                                        width: double.infinity,
                                        child: InkWell(
                                          onTap: () {
                                            studioProvider.getImage();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 36,
                                                color: Colors.black38,
                                              ),
                                              Text(
                                                "Upload Foto Studio",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.black38),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Container(
                                  //   child: Column(
                                  //       children: List.generate(
                                  //     studioProvider.studioPenyedia.first.image
                                  //                 .first ==
                                  //             'https://www.dauhpurikangin.id/uploads/default/noimages.png'
                                  //         ? 0
                                  //         : studioProvider.studioPenyedia.first
                                  //             .image.length,
                                  //     (index) => Column(
                                  //       children: [
                                  //         Container(
                                  //           color: Colors.grey,
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.end,
                                  //             children: [
                                  //               IconButton(
                                  //                 onPressed: () {
                                  //                   studioProvider.deleteImage(
                                  //                       studioProvider
                                  //                           .studioPenyedia
                                  //                           .first
                                  //                           .idImage[index]);
                                  //                   _fetchData(context);
                                  //                 },
                                  //                 icon: Icon(
                                  //                   Icons.close,
                                  //                   size: 30,
                                  //                   color: Colors.white,
                                  //                 ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //         Image.network(studioProvider
                                  //             .studioPenyedia
                                  //             .first
                                  //             .image[index]),
                                  //         SizedBox(
                                  //           height: 10,
                                  //         )
                                  //       ],
                                  //     ),
                                  //   )),
                                  // ),
                                  Container(
                                    child: Column(
                                        children: List.generate(
                                      studioProvider.imageStudio.length,
                                      (index) => Column(
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    studioProvider.imageStudio
                                                        .removeAt(index);
                                                    studioProvider.counter += 1;
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Image.file(studioProvider
                                              .imageStudio[index]),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      var data = {
                                        "nama_studio": namaStudio.text,
                                        "alamat": alamat.text,
                                        "deskripsi": deskripsi.text,
                                        "tarif_minimal":
                                            int.parse(tarifMinimal.text),
                                        "tarif_maksimal":
                                            int.parse(tarifMaksimal.text),
                                      };
                                      PesanKonfirmasi(context, data);

                                      //studioProvider.updateStudio(data, context);

                                      // PesanKonfirmasi(context, namaStudio.text,
                                      //     alamat.text, deskripsi.text);
                                    }
                                  },
                                  child: Text("Simpan")),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
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
    await Future.delayed(const Duration(seconds: 1));

    // Close the dialog programmatically
    Navigator.of(context).pop();
    //getDataStudio(context, '/kelolaStudio');
    Navigator.pushNamed(context, KelolaStudio.routeName);
  }
}
