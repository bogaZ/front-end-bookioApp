import 'package:bookio2/provider/RatingProvider.dart';
import 'package:bookio2/widget/rating_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SemuaUlasan extends StatelessWidget {
  static const routeName = "/semuaUlasan";
  SemuaUlasan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MENGAMBIL //!ID DARI STUDIO YANG DIPILIH
    final idStudio = ModalRoute.of(context)!.settings.arguments as String;

    final rating = Provider.of<RatingProvider>(context)
        .dataRating
        .where((element) => element.idStudio == idStudio)
        .toList();

    List<Widget> ulasan = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Ulasan"),
      ),
      body: Center(
        child: Container(
          width: 380,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Center(
              child: ListView(
                children: List.generate(
                    rating.length,
                    (index) => Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: RatingCard(
                              nama: rating[index].nama,
                              rating: rating[index].rating,
                              tanggal: rating[index].tanggal),
                        )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
