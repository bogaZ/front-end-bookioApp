import 'package:bookio2/models/jadwal.dart';
import 'package:bookio2/provider/penyedia/DropDownProvider.dart';
import 'package:bookio2/provider/JadwalProvider.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';

class DropDownJamAkhir extends StatelessWidget {
  int index;
  JadwalProvider dataJadwal;
  List<String> dataJamAkhir;
  DropDownJamAkhir(
      {required this.dataJamAkhir,
      required this.dataJadwal,
      required this.index});

  String? jamAkhir;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (dataJamAkhir.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<DropDownProvider>(context);
    final jadwalProvider = Provider.of<JadwalProvider>(context);

    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            dropdownMaxHeight: 200,
            isExpanded: true,
            hint: Text(
              ' ' + dataJadwal.jadwalPenyedia[index].jamTutup,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: _addDividersAfterItems(myData.myJamAkhir),
            customItemsIndexes: _getDividersIndexes(),
            customItemsHeight: 4,
            value: jamAkhir,
            onChanged: (value) {
              dataJamAkhir = myData.myJamAkhir;
              myData.cekJamAkhir(value.toString());
              jamAkhir = value.toString();
              //jadwalProvider.counter += 1;
              dataJadwal.tampungJamAkhir.first = value.toString();
              myData.counter += 1;
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ),
      ],
    );
  }
}
