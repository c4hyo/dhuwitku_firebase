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
      await userCredential.user.updateProfile(
        displayName: nama,
      );

      await users.doc(userCredential.user.uid).set({
        "nama": nama,
        "telepon": null,
        "jenis_kelamin": null,
        "tempat_tanggal_lahir": null,
        "is_admin": false
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

      return userCredential.user;
    } catch (e) {
      return e;
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<void> changePassword({String password, User user}) async {
    try {
      await user.updatePassword(password);
      return await auth.signOut();
    } catch (e) {
      return e;
    }
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
      await user.updateProfile(displayName: model.nama);
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
