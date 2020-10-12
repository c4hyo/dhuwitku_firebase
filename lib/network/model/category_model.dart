import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String nama;
  String uid;

  CategoryModel({
    this.nama,
    this.uid,
  });

  factory CategoryModel.toMaps(DocumentSnapshot doc) {
    return CategoryModel(
      nama: doc.data()['nama'] ?? "",
      uid: doc.id,
    );
  }
}
