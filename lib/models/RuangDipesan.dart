class RuangDipesan {
  int idRuang;

  String namaRuang;
  String jamAwal;
  String jamAkhir;
  int totalDurasi;
  int totalPembayaran;
  String tanggal;
  String status;
  DateTime dedline;

  RuangDipesan(
      {required this.idRuang,
      required this.namaRuang,
      required this.jamAwal,
      required this.jamAkhir,
      required this.totalDurasi,
      required this.totalPembayaran,
      required this.tanggal,
      required this.status,
      required this.dedline});
}
