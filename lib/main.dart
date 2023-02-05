// import 'package:bookio2/ExampleImagePicker.dart';
// import 'package:bookio2/page/BeriUlasan.dart';
import 'package:bookio2/page/DetailPemesanan.dart';
import 'package:bookio2/page/DetailStudioPage.dart';
import 'package:bookio2/page/InformasiPribadi.dart';
import 'package:bookio2/page/Notifikasi.dart';
import 'package:bookio2/page/Pembayaran.dart';
import 'package:bookio2/page/PilihJadwal.dart';
import 'package:bookio2/page/Profil.dart';
import 'package:bookio2/page/SemuaUlasan.dart';
import 'package:bookio2/page/SplashScreen.dart';
import 'package:bookio2/page/UbahPassword.dart';
import 'package:bookio2/page/penyedia/CekTransaksi.dart';
// import 'package:bookio2/page/penyedia/Daftar.dart';
import 'package:bookio2/page/penyedia/DetailPemesanan.dart';
import 'package:bookio2/page/penyedia/DetailPemesananAplikasi.dart';
import 'package:bookio2/page/penyedia/DetailWithdraw.dart';
import 'package:bookio2/page/penyedia/EditDataStudio.dart';
import 'package:bookio2/page/penyedia/FirstLogin/TambahDataStudio.dart';
// import 'package:bookio2/page/penyedia/HomePenyedia.dart';
import 'package:bookio2/page/penyedia/InformasiPembayaran.dart';
import 'package:bookio2/page/penyedia/InformasiPribadiPenyedia.dart';
import 'package:bookio2/page/penyedia/KelolaJadwal.dart';
import 'package:bookio2/page/penyedia/KelolaRuangStudio.dart';
import 'package:bookio2/page/penyedia/KelolaStudio.dart';
// import 'package:bookio2/page/penyedia/Login.dart';
import 'package:bookio2/page/penyedia/NotofikasiPenyedia.dart';
import 'package:bookio2/page/penyedia/PemesananLangsung.dart';
import 'package:bookio2/page/penyedia/PemesananMelaluiAplikasi.dart';
import 'package:bookio2/page/penyedia/PemesananPenyedia.dart';
import 'package:bookio2/page/penyedia/ProfilePenyedia.dart';
import 'package:bookio2/page/penyedia/TambahPemesanan.dart';
import 'package:bookio2/page/penyedia/TambahWithdraw.dart';
import 'package:bookio2/page/penyedia/UbahPasswordPenyedia.dart';
import 'package:bookio2/page/penyedia/Withdraw.dart';
import 'package:bookio2/provider/AutenticationProvider.dart';
import 'package:bookio2/provider/NotifikasiProvider.dart';
import 'package:bookio2/provider/penyedia/DropDownProvider.dart';
import 'package:bookio2/provider/JadwalProvider.dart';
import 'package:bookio2/provider/PemesananProvider.dart';
import 'package:bookio2/provider/RatingProvider.dart';
import 'package:bookio2/provider/RuangDipesanProvider.dart';
import 'package:bookio2/provider/RuangProvider.dart';
import 'package:bookio2/provider/StudioProvider.dart';
import 'package:bookio2/provider/UserProvider.dart';
// import 'package:bookio2/provider/penyedia/ExportPDFProvider.dart';
import 'package:bookio2/provider/penyedia/PemesananLangsungProvider.dart';
import 'package:bookio2/provider/penyedia/PemesananProvider.dart';
import 'package:bookio2/provider/penyedia/RekeningProvider.dart';
import 'package:bookio2/provider/penyedia/WithdrawProvider.dart';
import 'package:bookio2/services/JadwalServices.dart';
import 'package:bookio2/services/RekeningService.dart';
import 'package:bookio2/services/WithdrawServices.dart';
import 'package:bookio2/widget/button_navbar.dart';
import 'package:bookio2/widget/penyedia/ButtonNavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => StudioProvider()),
        ChangeNotifierProvider(create: (context) => RatingProvider()),
        ChangeNotifierProvider(create: (context) => RuangProvider()),
        ChangeNotifierProvider(create: (context) => JadwalProvider()),
        ChangeNotifierProvider(create: (context) => PemesananProvider()),
        ChangeNotifierProvider(create: (context) => RuangDipesanProvider()),
        ChangeNotifierProvider(create: (context) => AutenticationProvider()),

        // PROVIDER //! PENYEDIA STUDIO
        ChangeNotifierProvider(create: (context) => DropDownProvider()),
        ChangeNotifierProvider(
            create: (context) => PemesananLangsungProvider()),
        ChangeNotifierProvider(
            create: (context) => PemesananMelaluiAplikasiProvider()),
        ChangeNotifierProvider(create: ((context) => WithdrawProvider())),
        ChangeNotifierProvider(create: (context) => RekeningProvider()),
        ChangeNotifierProvider(create: (context) => NotifikasiProvider()),
        //ChangeNotifierProvider(create: (context) => ExportPDFProvider()),

        // services
        ChangeNotifierProvider(create: (context) => WithdrawServices()),
        ChangeNotifierProvider(create: (context) => RekeningService()),
        ChangeNotifierProvider(create: (context) => JadwalServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bookio',
        // home: BottomNavbarPenyedia(
        //   argument: 0,
        // ),
        home: const SplashPage(),
        //initialRoute: BottomNavbar.nameRoute,
        routes: {
          // ROUTE //! PENYEWA STUDIO
          BottomNavbar.nameRoute: (context) => const BottomNavbar(argument: 0),
          DetailStudio.nameRoute: (context) => const DetailStudio(),
          PilihJadwal.nameRoute: (context) => PilihJadwal(),
          Pembayaran.routeName: (context) => Pembayaran(),
          Notifikasi.routeName: (context) => Notifikasi(),
          InformasiPribadi.routeName: (context) => InformasiPribadi(),
          UbahPassword.routeName: (context) => UbahPassword(),
          SemuaUlasan.routeName: (conterx) => SemuaUlasan(),
          DetailPemesanan.routeName: (context) => const DetailPemesanan(),

          // ROUTE //! PENYEDIA STUDIO
          BottomNavbarPenyedia.nameRoute: (context) => BottomNavbarPenyedia(
                argument: 0,
              ),
          KelolaRuangStudio.routeName: (context) => const KelolaRuangStudio(),
          KelolaStudio.routeName: (context) => KelolaStudio(),
          EditDataStudio.routeName: (context) => EditDataStudio(),
          KelolaJadwal.routeName: (context) => const KelolaJadwal(),
          PemesananPenyedia.routeName: (context) => const PemesananPenyedia(),
          PemesananLangsung.routeName: (context) => PemesananLangsung(),
          DetailPemesananPenyedia.routeName: (context) =>
              const DetailPemesananPenyedia(),
          TambahPemesanan.routeName: (context) => TambahPemesanan(),
          PemesananMelaluiAplikasi.routeName: (context) =>
              const PemesananMelaluiAplikasi(),
          DetailPemesananMelaluiAplikasi.routeName: (context) =>
              const DetailPemesananMelaluiAplikasi(),
          Withdraw.routeName: (context) => Withdraw(),
          DetailWithdraw.routeName: (context) => const DetailWithdraw(),
          TambahWithdraw.routeName: (context) => const TambahWithdraw(),
          ProfilPenyedia.routeName: (context) => const ProfilPenyedia(),
          InformasiPribadiPenyedia.routeName: (context) =>
              InformasiPribadiPenyedia(),
          InformasiPembayaran.routeName: (context) => InformasiPembayaran(),
          UbahPasswordPenyedia.routeName: (context) => UbahPasswordPenyedia(),
          NotifikasiPenyedia.routeName: (context) => const NotifikasiPenyedia(),
          CekTransaksi.routeNmae: (context) => const CekTransaksi(),
          TambahDataStudio.routeName: (context) => TambahDataStudio(),
          Profil.routeName: (context) => const Profil(),
        },
      ),
    );
  }
}
