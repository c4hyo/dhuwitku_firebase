import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String judul;
  String deskripsi;
  String uid;
  String waktuBuat;
  bool isPin;
  bool isDone;
  String kategori;

  NoteModel({
    this.judul,
    this.waktuBuat,
    this.uid,
    this.kategori,
    this.deskripsi,
    this.isDone,
    this.isPin,
  });

  factory NoteModel.toMaps(DocumentSnapshot doc) {
    return NoteModel(
      deskripsi: doc.data()['deskripsi'] ?? "",
      isDone: doc.data()['is_done'] ?? false,
      isPin: doc.data()['is_pin'] ?? false,
      judul: doc.data()['judul'] ?? "",
      waktuBuat: doc.data()['waktu_buat'] ?? "",
      uid: doc.id,
      kategori: doc.data()['kategori'] ?? "",
    );
  }
}
