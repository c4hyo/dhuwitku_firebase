import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAllScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;

  const UserAllScreen({Key key, this.user, this.isAdmin, this.userModel})
      : super(key: key);
  @override
  _UserAllScreenState createState() => _UserAllScreenState();
}

class _UserAllScreenState extends State<UserAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Semua Pengguna",
          style: TextStyle(
            color: tuatara,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: turquoise,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                turquoise,
                roseQ,
                cream,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream: UserServices.users
                  .where("is_admin", isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot d = snapshot.data.docs[index];
                    UserModel user = UserModel.toMaps(d);
                    return Card(
                      child: ExpansionTile(
                        title: Text(
                          user.nama,
                          style: TextStyle(
                            color: tuatara,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        childrenPadding: EdgeInsets.all(10),
                        expandedAlignment: Alignment.topLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Catatan: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: UserServices.users
                                .doc(user.uid)
                                .collection("note")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("0");
                              }
                              return Text(
                                snapshot.data.docs.length.toString(),
                              );
                            },
                          ),
                          Text(
                            "Catatan Keuangan: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: UserServices.users
                                .doc(user.uid)
                                .collection("money")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("0");
                              }
                              return Text(
                                snapshot.data.docs.length.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
