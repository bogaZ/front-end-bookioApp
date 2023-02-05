import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_card.dart';
import '../provider/StudioProvider.dart';

class GridStudio extends StatelessWidget {
  const GridStudio({super.key});

  @override
  Widget build(BuildContext context) {
    // PROVIDER //! DATA STUDIO MUSIK

    return Consumer<StudioProvider>(builder: (context, studioProvider, _) {
      return FutureBuilder(
          future: studioProvider.getAllDataStudio(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                studioProvider.counter += 1;
              },
              child: GridView.builder(
                itemCount: studioProvider.allStudio.length,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width <= 320
                      ? 1
                      : MediaQuery.of(context).size.width <= 425
                          ? 2
                          : MediaQuery.of(context).size.width <= 768
                              ? 4
                              : 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 5,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return CustomCard(
                      id: studioProvider.allStudio[index].id,
                      title: studioProvider.allStudio[index].nama,
                      image: studioProvider.allStudio[index].image.first,
                      tarif: studioProvider.allStudio[index].tarifMinimal,
                      rating: studioProvider.allStudio[index].rating,
                      jumlah: 0);
                },
              ),
            );
          });
    });
  }
}
