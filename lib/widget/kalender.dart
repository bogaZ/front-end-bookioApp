import 'package:bookio2/provider/PilihJadwalProvider.dart';
import 'package:bookio2/services/PilihJadwalServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// TAMPILAN //!KALENDER
@immutable
class KalenderBookio extends StatelessWidget {
  final int idStudio;
  const KalenderBookio({super.key, required this.idStudio});
  @override
  Widget build(BuildContext context) {
    // MENGAMBIL //! DATA TANGGAL DARI PROVIDER PILIH JADWAL
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    final pilihJadwalServices =
        Provider.of<PilihJadwalServices>(context, listen: false);
    return Consumer<PilihJadwalProvider>(
      builder: (context, pilihJadwalProvider, _) => TableCalendar(
        focusedDay: pilihJadwalProvider.tanggalDipilih,
        firstDay: pilihJadwalProvider.fokusTanggal,
        // last day harus melebihi tahun sekarang
        lastDay: DateTime.utc(year, month + 3),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(pilihJadwalProvider.tanggalDipilih, date);
        },
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          //pilihJadwalProvider.counter = 0;
          if (pilihJadwalProvider.mydataRuang.isNotEmpty) {
            pilihJadwalProvider.listJam();
            pilihJadwalProvider.listHandleJam();
            pilihJadwalProvider.listJamDipilih();
          }
          pilihJadwalProvider.tampungRuangDipesan.clear();
          pilihJadwalProvider.tanggalDipilih = selectDay;
          pilihJadwalProvider.ambilHari();
          pilihJadwalProvider.totalDuration = 0;
          pilihJadwalProvider.totalPembayaran = 0;
          pilihJadwalServices.counter += 1;
        },
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          selectedDecoration: BoxDecoration(
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
