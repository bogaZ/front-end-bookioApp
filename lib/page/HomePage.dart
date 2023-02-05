import 'package:bookio2/models/Studios.dart';
import 'package:bookio2/page/Notifikasi.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import '../widget/grid_studio.dart';

class HomePenyewa extends StatefulWidget {
  HomePenyewa({Key? key}) : super(key: key);

  @override
  _HomePenyewaState createState() => _HomePenyewaState();
}

class _HomePenyewaState extends State<HomePenyewa> {
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final dataUser = Provider.of<UserProvider>(context).dataUser;
    final pencarian = TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudioProvider()),
      ],
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'bookio',
                                  style: TextStyle(
                                    color: Colors.transparent,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                  ),
                                ),
                                // Container(
                                //   width: 105,
                                //   height: 5,
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                            // Badge(
                            //   badgeContent: Text(
                            //     '3',
                            //     style: TextStyle(
                            //       color: Colors.orange,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            //   showBadge: true,
                            //   shape: BadgeShape.circle,
                            //   badgeColor: Colors.white,
                            //   elevation: 4,
                            //   padding: const EdgeInsetsDirectional.fromSTEB(
                            //       8, 8, 8, 8),
                            //   position: BadgePosition.topEnd(),
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.pushNamed(
                            //           context, Notifikasi.routeName);
                            //     },
                            //     child: Icon(
                            //       Icons.notifications,
                            //       size: 32,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<UserProvider>(
                                builder: (context, userProvider, _) {
                              return FutureBuilder(
                                  future: userProvider.getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.deepOrange),
                                      );
                                    }
                                    return Text(
                                      "Hai, ${userProvider.userData['name']}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  });
                            }),
                            Text(
                              'Mencari Tempat Studio Musik ?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: Consumer<StudioProvider>(
                                  builder: (context, studioProvider, _) {
                                return TextFormField(
                                  onChanged: (value) {
                                    studioProvider.pencarian(value);
                                    studioProvider.counter += 1;
                                  },
                                  keyboardType: TextInputType.text,
                                  //autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Pencarian Tempat Studio Musik',
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
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Pilih Studio Musik',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    // TAMPILAN //! GRID STUDIO MUSIK
                    child: GridStudio(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
