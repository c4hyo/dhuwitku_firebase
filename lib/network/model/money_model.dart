import 'package:cloud_firestore/cloud_firestore.dart';

class MoneyModel {
  String nama;
  String jenis;
  String uid;
  String waktuBuat;
  int nominal;
  String kategori;
  String deskripsi;

  MoneyModel({
    this.nominal,
    this.nama,
    this.jenis,
    this.waktuBuat,
    this.uid,
    this.kategori,
    this.deskripsi,
  });

  factory MoneyModel.toMaps(DocumentSnapshot doc) {
    return MoneyModel(
      nominal: doc.data()['nominal'] ?? 0,
      nama: doc.data()['nama'] ?? "",
      jenis: doc.data()['jenis'] ?? "",
      deskripsi: doc.data()['deskripsi'] ?? "",
      waktuBuat: doc.data()['waktu_buat'] ?? "",
      uid: doc.id,
      kategori: doc.data()['kategori'] ?? "",
    );
  }
}
