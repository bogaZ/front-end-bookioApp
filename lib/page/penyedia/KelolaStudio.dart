import 'package:bookio2/page/penyedia/EditDataStudio.dart';
import 'package:bookio2/page/penyedia/KelolaJadwal.dart';
import 'package:bookio2/page/penyedia/KelolaRuangStudio.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class KelolaStudio extends StatefulWidget {
  static const routeName = "/kelolaStudio";

  @override
  State<KelolaStudio> createState() => _KelolaStudioState();
}

class _KelolaStudioState extends State<KelolaStudio> {
  late PageController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // PROVIDER //! DATA STUDIO

    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, BottomNavbarPenyedia.nameRoute);
          return false;
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => StudioProvider()),
          ],
          child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, BottomNavbarPenyedia.nameRoute);
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
                backgroundColor: Colors.deepOrange,
                title: Text("Kelola Studio"),
              ),
              body: Consumer<StudioProvider>(
                  builder: (context, studioProvider, _) {
                return FutureBuilder(
                  future: studioProvider.getData(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            CircularProgressIndicator(color: Colors.deepOrange),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black26,
                          child: Container(
                            height: 250.0,
                            child: PageIndicatorContainer(
                              indicatorSelectorColor: Colors.deepOrange,
                              child: PageView(
                                children: List.generate(
                                  studioProvider
                                      .studioPenyedia.first.image.length,
                                  (index) {
                                    return Stack(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        studioProvider
                                                            .studioPenyedia
                                                            .first
                                                            .image[index]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        studioProvider.studioPenyedia.first
                                                    .image.first ==
                                                'https://www.dauhpurikangin.id/uploads/default/noimages.png'
                                            ? Container()
                                            : Container(
                                                color: Color.fromARGB(
                                                    71, 255, 255, 255),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        studioProvider.deleteImage(
                                                            studioProvider
                                                                .studioPenyedia
                                                                .first
                                                                .idImage[index],
                                                            context);
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        size: 30,
                                                        color:
                                                            Colors.deepOrange,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                ),

                                //reverse: true,
                              ),
                              align: IndicatorAlign.bottom,
                              length: studioProvider
                                  .studioPenyedia.first.image.length,
                              indicatorSpace: 10.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(studioProvider.studioPenyedia.first.nama,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tarif Minimal : ",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Text(NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(studioProvider
                                          .studioPenyedia.first.tarifMinimal)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black38,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.deepOrange,
                                  ),
                                  Text(
                                    "Alamat",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                studioProvider.studioPenyedia.first.alamat,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black38,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: studioProvider.studioPenyedia
                                                      .first.StatusTempat !=
                                                  'Terverifikasi'
                                              ? Colors.red
                                              : Colors.blue),
                                      onPressed: () {},
                                      child: Text(studioProvider
                                          .studioPenyedia.first.StatusTempat)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: studioProvider.studioPenyedia
                                                      .first.StatusTransaksi !=
                                                  'Aktif'
                                              ? Colors.grey
                                              : Colors.green),
                                      onPressed: () {},
                                      child: Text(studioProvider.studioPenyedia
                                          .first.StatusTransaksi)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black38,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                studioProvider.studioPenyedia.first.deskripsi,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, EditDataStudio.routeName);
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
                                              'Edit Data Studio',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "Mengedit Data Studio",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black26),
                                            )
                                          ],
                                        ),

                                        leading: Icon(
                                          Icons.edit_calendar_outlined,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, KelolaRuangStudio.routeName);
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
                                              'Kelola Ruang',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "Mengelola Ruang Studio",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black26),
                                            )
                                          ],
                                        ),

                                        leading: Icon(
                                          Icons.room_preferences_outlined,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, KelolaJadwal.routeName);
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
                                              'Kelola Jadwal',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "Mengelola jam operasional",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black26),
                                            )
                                          ],
                                        ),

                                        leading: Icon(
                                          Icons.calendar_month,
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
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              })),
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
