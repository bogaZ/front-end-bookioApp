import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/models/ruang.dart';
import 'package:flutter/widgets.dart';
import '../models/Studios.dart';

class belajar with ChangeNotifier {
  // DATA DUMMY //! ALL STUDIO MUSIK
  List<Studios> _allStudio = [];
  List<Studios> get allStudio => _allStudio;

  // METHOD //! CONVERT MODELS KE LIST MAP
  // List<Map<String, dynamic>> mapListStudio = [];
  // convertModelsToMap() {
  //   int panjangData = allStudio.length;
  //   for (int i = 0; i < panjangData; i++) {
  //     mapListStudio.add({
  //       "id_studio": allStudio[i].id,
  //       "nama": allStudio[i].nama,
  //       "lokasi": allStudio[i].lokasi,
  //       "deskripsi": allStudio[i].deskripsi,
  //       "rating": allStudio[i].rating,
  //       "jumlah": allStudio[i].jumlah,
  //       "min_tarif": allStudio[i].tarifMinimal,
  //       "image": [
  //         for (int j = 0; j < allStudio[i].image.length; j++)
  //           {"link_url": allStudio[i].image[j]}
  //       ],
  //       "jadwal": [
  //         for (int j = 0; j < allStudio[i].jadwal.length; j++)
  //           {
  //             "id_jadwal": allStudio[i].jadwal[j].id,
  //             "hari": allStudio[i].jadwal[j].hari,
  //             "status": allStudio[i].jadwal[j].status
  //           }
  //       ],
  //       "Ruang": [
  //         for (int j = 0; j < allStudio[i].ruang.length; j++)
  //           {
  //             "id_ruang": allStudio[i].ruang[j].id,
  //             "nama_ruang": allStudio[i].ruang[j].nama,
  //             "tarif": allStudio[i].ruang[j].tarif
  //           }
  //       ]
  //     });
  //   }
  //   print(mapListStudio);
  // }

  // METHOD //! CONVERT DARI MAP LIST KE MODELS
  List<Map<String, dynamic>> dataMapStudio = [
    {
      "id_studio": 0,
      "nama": "Studio 1",
      "lokasi": "lokasi",
      "deskripsi": "deskripsi",
      "rating": 5,
      "jumlah": 4,
      "min_tarif": 10000,
      "image": [
        {
          "link_url":
              "https://images.unsplash.com/photo-1598653222000-6b7b7a552625?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"
        },
        {
          "link_url":
              "https://images.unsplash.com/photo-1567787609897-efa3625dd22d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"
        }
      ],
      "jadwal": [
        {
          "id_jadwal": "0",
          "hari": "senin",
          "status": [false, false]
        }
      ],
      "ruang": [
        {"id_ruang": "0", "nama_ruang": "Ruang 1", "tarif": 20000},
        {"id_ruang": "2", "nama_ruang": "Ruang 2", "tarif": 30000}
      ]
    },
  ];

  List<Studios> modalsStudio = [];

  // convertMapToModals() {
  //   int panjangData = dataMapStudio.length;
  //   for (int i = 0; i < panjangData; i++) {
  //     modalsStudio.add(Studios(
  //         dataMapStudio[i]["id_studio"],
  //         dataMapStudio[i]["nama"],
  //         dataMapStudio[i]["deskripsi"],
  //         dataMapStudio[i]["lokasi"],
  //         dataMapStudio[i]["image"].map((e) => e["link_url"]).toList(),
  //         dataMapStudio[i]["min_tarif"],
  //         [
  //           for (int j = 0; j < dataMapStudio[i]["jadwal"].length; j++)
  //             {
  //               Jadwal(
  //                   dataMapStudio[i]["jadwal"][j]["id_jadwal"],
  //                   dataMapStudio[i]["jadwal"][j]["hari"],
  //                   dataMapStudio[i]["jadwal"][j]["status"])
  //             }
  //         ],
  //         [
  //           for (int j = 0; j < dataMapStudio[i]["ruang"].length; j++)
  //             {
  //               Ruang(
  //                   dataMapStudio[i]["ruang"][j]["id_ruang"],
  //                   dataMapStudio[i]["ruang"][j]["nama_ruang"],
  //                   dataMapStudio[i]["ruang"][j]["tarif"])
  //             }
  //         ],
  //         dataMapStudio[i]["rating"],
  //         dataMapStudio[i]["jumlah"]));
  //   }
  //   print(modalsStudio[0].image[0]);
  // }
}
