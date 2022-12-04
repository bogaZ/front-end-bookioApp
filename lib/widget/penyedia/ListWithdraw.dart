import 'package:bookio2/page/penyedia/DetailWithdraw.dart';
import 'package:bookio2/provider/penyedia/WithdrawProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListWithdraw extends StatelessWidget {
  int index;
  ListWithdraw({required this.index});

  @override
  Widget build(BuildContext context) {
    final dataWithdraw = Provider.of<WithdrawProvider>(context);
    return InkWell(
      key: UniqueKey(),
      onTap: () {
        Navigator.pushNamed(context, DetailWithdraw.routeName,
            arguments: index);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    dataWithdraw.dataWithdraw[index].status != 'Lunas'
                        ? Icons.monetization_on_outlined
                        : Icons.check_circle,
                    size: 36,
                    color: dataWithdraw.dataWithdraw[index].status != 'Lunas'
                        ? Colors.deepOrange
                        : Colors.green,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0)
                                .format(
                                    dataWithdraw.dataWithdraw[index].nominal),
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Status : ',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                          ),
                          Text(
                            dataWithdraw.dataWithdraw[index].status,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    dataWithdraw.dataWithdraw[index].status !=
                                            'Lunas'
                                        ? Colors.red
                                        : Colors.green),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        dataWithdraw.dataWithdraw[index].tanggal
                            .substring(0, 10),
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),

          //tileColor: Colors.black26,
        ),
      ),
    );
  }
}
