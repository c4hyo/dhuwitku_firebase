import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String nama;
  String telepon;
  String uid;
  String tempatTanggalLahir;
  bool isAdmin;
  String jenisKelamin;

  UserModel({
    this.isAdmin,
    this.nama,
    this.telepon,
    this.tempatTanggalLahir,
    this.uid,
    this.jenisKelamin,
  });

  factory UserModel.toMaps(DocumentSnapshot doc) {
    return UserModel(
      jenisKelamin: doc.data()['jenis_kelamin'] ?? "",
      isAdmin: doc.data()['is_admin'] ?? false,
      nama: doc.data()['nama'] ?? "",
      telepon: doc.data()['telepon'] ?? "",
      tempatTanggalLahir: doc.data()['tempat_tanggal_lahir'] ?? "",
      uid: doc.id,
    );
  }
}
