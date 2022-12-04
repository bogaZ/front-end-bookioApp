class Pemesanan {
  // BLUEPRINT //! MODAL PEMESANANAN
  int id;
  String invoice;
  dynamic idUser;
  String namaUser;
  String nomorHp;
  int idStudio;
  String namaStudio;
  String alamatStudio;
  DateTime tanggal;
  int totalPembayaran;
  String status;
  DateTime dedline;
  dynamic fasilitasDipesan;

  Pemesanan({
    required this.id,
    required this.invoice,
    required this.idUser,
    required this.namaUser,
    required this.nomorHp,
    required this.idStudio,
    required this.namaStudio,
    required this.alamatStudio,
    required this.tanggal,
    required this.totalPembayaran,
    required this.status,
    required this.dedline,
    required this.fasilitasDipesan,
  });
}
