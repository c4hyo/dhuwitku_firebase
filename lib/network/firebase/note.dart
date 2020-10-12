import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/note_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteServices {
  static Future<void> addNote({NoteModel model, User user}) async {
    try {
      return await UserServices.users.doc(user.uid).collection("note").add({
        "judul": model.judul,
        "deskripsi": model.deskripsi,
        "waktu_buat": DateTime.now().toString(),
        "kategori": model.kategori,
        "is_pin": false,
      });
    } catch (e) {
      return e;
    }
  }

  static Future<void> updateNote({
    NoteModel model,
    User user,
    String idNote,
  }) async {
    try {
      return await UserServices.users
          .doc(user.uid)
          .collection("note")
          .doc(idNote)
          .set(
        {
          "judul": model.judul,
          "deskripsi": model.deskripsi,
          "kategori": model.kategori,
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      return e;
    }
  }

  static Future<void> deleteNote({NoteModel model, User user}) async {
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

  static Future<void> pinNote({NoteModel model, User user}) async {
    try {
      return await UserServices.users
          .doc(user.uid)
          .collection("note")
          .doc(model.uid)
          .set(
        {
          "is_pin": !model.isPin,
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      return e;
    }
  }
}
