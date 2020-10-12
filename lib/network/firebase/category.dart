import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/model/category_model.dart';

class CategoryClass {
  static CollectionReference ctg =
      FirebaseFirestore.instance.collection("categories");
  static Future<void> addMoney({CategoryModel model}) async {
    try {
      return await ctg.add({
        "nama": model.nama,
      });
    } catch (e) {
      return e;
    }
  }

  static Future<void> updateMoney({CategoryModel model}) async {
    try {
      return await ctg.doc(model.uid).set(
        {
          "nama": model.nama,
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      return e;
    }
  }

  static Future<void> deleteMoney({CategoryModel model}) async {
    try {
      return await ctg.doc(model.uid).delete();
    } catch (e) {
      return e;
    }
  }
}
