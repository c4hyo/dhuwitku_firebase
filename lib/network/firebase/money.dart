import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/money_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MoneyService {
  static Future<void> addMoney({
    MoneyModel model,
    User user,
  }) async {
    try {
      return await UserServices.users.doc(user.uid).collection("money").add({
        "nama": model.nama,
        "deskripsi": model.deskripsi,
        "jenis": model.jenis,
        "waktu_buat": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "kategori": model.kategori,
        "nominal": model.nominal,
      });
    } catch (e) {
      return e;
    }
  }

  static Future<void> updateMoney({
    MoneyModel model,
    User user,
    String idMoney,
  }) async {
    try {
      return await UserServices.users
          .doc(user.uid)
          .collection("money")
          .doc(idMoney)
          .set(
        {
          "nama": model.nama,
          "jenis": model.jenis,
          "deskripsi": model.deskripsi,
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

  static Future<void> deleteMoney({
    MoneyModel model,
    User user,
  }) async {
    try {
      return await UserServices.users
          .doc(user.uid)
          .collection("money")
          .doc(model.uid)
          .delete();
    } catch (e) {
      return e;
    }
  }
}
