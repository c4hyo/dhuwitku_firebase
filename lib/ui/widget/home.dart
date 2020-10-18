import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:dhuwitku_firebase/utilities/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

Widget homeUser({UserModel userModel, User user}) {
  int _pengeluaranT = 0;
  int _pemasukanT = 0;
  int _pengeluaran = 0;
  int _pemasukan = 0;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Welcome ${userModel.nama}",
        style: TextStyle(
          fontSize: 20,
          color: tuatara,
        ),
      ),
      Text(
        DateFormat("EEEE, d MMMM yyyy", "id_ID").format(
          DateTime.now(),
        ),
        style: TextStyle(
          color: tuatara,
          fontSize: 15,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      StreamBuilder<QuerySnapshot>(
        stream: UserServices.users.doc(user.uid).collection("note").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: turquoise,
              child: ListTile(
                title: Text("Catatan Saya"),
                trailing: Icon(
                  FontAwesome.sticky_note,
                  size: 80,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            );
          }
          return Card(
            color: turquoise,
            child: ListTile(
              title: Text("Catatan Saya"),
              trailing: Icon(
                FontAwesome.sticky_note,
                size: 80,
              ),
              subtitle: Text(
                snapshot.data.docs.length.toString(),
                style: TextStyle(fontSize: 50),
              ),
            ),
          );
        },
      ),
      SizedBox(
        height: 10,
      ),
      StreamBuilder<QuerySnapshot>(
        stream:
            UserServices.users.doc(user.uid).collection("money").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: peach,
              child: ListTile(
                title: Text("Catatan Saya Keuangan"),
                trailing: Icon(
                  FontAwesome.money,
                  size: 80,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            );
          }
          return Card(
            color: peach,
            child: ListTile(
              title: Text("Catatan Saya Keuangan"),
              trailing: Icon(
                FontAwesome.money,
                size: 80,
              ),
              subtitle: Text(
                snapshot.data.docs.length.toString(),
                style: TextStyle(fontSize: 50),
              ),
            ),
          );
        },
      ),
      SizedBox(
        height: 10,
      ),
      StreamBuilder<QuerySnapshot>(
        stream:
            UserServices.users.doc(user.uid).collection("money").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: roseQ,
              child: ListTile(
                title: Text("Pengeluaran Saya (Total)"),
                trailing: Icon(
                  FontAwesome.money,
                  size: 40,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            );
          }
          snapshot.data.docs
              .where((element) => element['jenis'] == "Pengeluaran")
              .forEach((element) {
            _pengeluaranT += element['nominal'];
          });
          return Card(
            color: roseQ,
            child: ListTile(
              title: Text("Pengeluaran Saya (Total)"),
              trailing: Icon(
                FontAwesome.money,
                size: 40,
              ),
              subtitle: Text(
                rupiah(nominal: _pengeluaranT),
                style: TextStyle(fontSize: 25),
              ),
            ),
          );
        },
      ),
      SizedBox(
        height: 5,
      ),
      StreamBuilder<QuerySnapshot>(
        stream:
            UserServices.users.doc(user.uid).collection("money").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: roseQ,
              child: ListTile(
                title: Text("Pemasukan Saya (Total)"),
                trailing: Icon(
                  FontAwesome.money,
                  size: 40,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            );
          }
          snapshot.data.docs
              .where((element) => element['jenis'] == "Pemasukan")
              .forEach((element) {
            _pemasukanT += element['nominal'];
          });
          return Card(
            color: roseQ,
            child: ListTile(
              title: Text("Pemasukan Saya (Total)"),
              trailing: Icon(
                FontAwesome.money,
                size: 40,
              ),
              subtitle: Text(
                rupiah(nominal: _pemasukanT),
                style: TextStyle(fontSize: 25),
              ),
            ),
          );
        },
      ),
      SizedBox(
        height: 10,
      ),
      StreamBuilder<QuerySnapshot>(
        stream: UserServices.users
            .doc(user.uid)
            .collection("money")
            .where(
              "waktu_buat",
              isEqualTo: DateFormat('yyyy-MM-dd').format(
                DateTime.now(),
              ),
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: cream,
              child: ListTile(
                title: Text("Pengeluaran Saya (Hari ini)"),
                trailing: Icon(
                  FontAwesome.money,
                  size: 40,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            );
          }
          snapshot.data.docs
              .where((element) => element['jenis'] == "Pengeluaran")
              .forEach((element) {
            _pengeluaran += element['nominal'];
          });
          return Card(
            color: cream,
            child: ListTile(
              title: Text("Pengeluaran Saya (Hari ini)"),
              trailing: Icon(
                FontAwesome.money,
                size: 40,
              ),
              subtitle: Text(
                rupiah(nominal: _pengeluaran),
                style: TextStyle(fontSize: 25),
              ),
            ),
          );
        },
      ),
      SizedBox(
        height: 5,
      ),
      StreamBuilder<QuerySnapshot>(
        stream: UserServices.users
            .doc(user.uid)
            .collection("money")
            .where(
              "waktu_buat",
              isEqualTo: DateFormat('yyyy-MM-dd').format(
                DateTime.now(),
              ),
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: cream,
              child: ListTile(
                title: Text("Pemasukan Saya (Hari ini)"),
                trailing: Icon(
                  FontAwesome.money,
                  size: 40,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            );
          }
          snapshot.data.docs
              .where((element) => element['jenis'] == "Pemasukan")
              .forEach((element) {
            _pemasukan += element['nominal'];
          });
          return Card(
            color: cream,
            child: ListTile(
              title: Text("Pemasukan Saya (Hari ini)"),
              trailing: Icon(
                FontAwesome.money,
                size: 40,
              ),
              subtitle: Text(
                rupiah(nominal: _pemasukan),
                style: TextStyle(fontSize: 25),
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget homeAdmin({UserModel userModel, User user}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Welcome ${userModel.nama}",
        style: TextStyle(
          fontSize: 20,
          color: tuatara,
        ),
      ),
      Text(
        DateFormat("EEEE, d MMMM yyyy", "id_ID").format(
          DateTime.now(),
        ),
        style: TextStyle(
          color: tuatara,
          fontSize: 15,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      StreamBuilder<QuerySnapshot>(
        stream:
            UserServices.users.where("is_admin", isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              color: turquoise,
              child: ListTile(
                title: Text("Pengguna"),
                trailing: Icon(
                  FontAwesome.users,
                  size: 80,
                ),
                subtitle: Text(
                  "0",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            );
          }
          return Card(
            color: turquoise,
            child: ListTile(
              title: Text("Pengguna"),
              trailing: Icon(
                FontAwesome.sticky_note,
                size: 80,
              ),
              subtitle: Text(
                snapshot.data.docs.length.toString(),
                style: TextStyle(fontSize: 50),
              ),
            ),
          );
        },
      ),
    ],
  );
}
