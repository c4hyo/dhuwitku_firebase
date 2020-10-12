import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/money_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoneyService {
  static Future<void> addMoney({MoneyModel model, User user}) async {
    try {
      return await UserServices.users.doc(user.uid).collection("money").add({
        "judul": model.nama,
        "deskripsi": model.jenis,
        "waktu_buat": DateTime.now(),
        "kategori": model.kategori,
        "nominal": model.nominal,
      });
    } catch (e) {
      return e;
    }
  }

  static Future<void> updateMoney({MoneyModel model, User user}) async {
    try {
      return await UserServices.users
          .doc(user.uid)
          .collection("money")
          .doc(model.uid)
          .set(
        {
          "judul": model.nama,
          "deskripsi": model.jenis,
          "waktu_buat": DateTime.now(),
          "kategori": model.kategori,
          "nominal": model.nominal,
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      return e;
    }
  }

  static Future<void> deleteMoney({MoneyModel model, User user}) async {
    try {
      return await UserServices.users
          .doc(user.uid)
          .collection("note")
          .doc(model.uid)
          .delete();
    } catch (e) {
      return e;
    }
  }
}
