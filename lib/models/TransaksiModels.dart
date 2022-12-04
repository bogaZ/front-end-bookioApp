class TransaksiModels {
  int id;
  String invoice;
  String namaPenyewa;
  String namaStudio;
  DateTime tanggal;
  String jenis;
  int totalPembayaran;
  int totalBiayaAdmin;
  int totalPemasukan;

  TransaksiModels({
    required this.id,
    required this.invoice,
    required this.namaPenyewa,
    required this.namaStudio,
    required this.tanggal,
    required this.jenis,
    required this.totalPembayaran,
    required this.totalBiayaAdmin,
    required this.totalPemasukan,
  });
}
