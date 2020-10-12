import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  static Future<User> signup(
      {String nama, String email, String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await users.doc(userCredential.user.uid).set({
        "nama": nama,
        "telepon": null,
        "jenis_kelamin": null,
        "tempat_tanggal_lahir": null,
        "is_admin": false
      });
      await users.doc(userCredential.user.uid).collection("log-user").add({
        "action": "Membuat akun",
        "created_at": DateTime.now(),
      });
      return userCredential.user;
    } catch (e) {
      return e;
    }
  }

  static Future<User> signIn({String email, String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await users.doc(userCredential.user.uid).collection("log-user").add({
        "action": "Login",
        "created_at": DateTime.now(),
      });
      return userCredential.user;
    } catch (e) {
      return e;
    }
  }

  static Future<void> signOut(String id) async {
    await users.doc(id).collection("log-user").add({
      "action": "log out",
      "created_at": DateTime.now(),
    });
    await auth.signOut();
  }

  static Stream<User> get checkUser => auth.authStateChanges();

  static Future<DocumentSnapshot> getProfil(String id) async {
    try {
      return await users.doc(id).get();
    } catch (e) {
      return e;
    }
  }

  static Future<void> updateProfil({User user, UserModel model}) async {
    try {
      return await users.doc(user.uid).set(
        {
          "nama": model.nama,
          "telepon": model.telepon,
          "jenis_kelamin": model.jenisKelamin,
          "tempat_tanggal_lahir": model.tempatTanggalLahir,
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
