import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/ui/screen/profile/ganti_password.dart';
import 'package:dhuwitku_firebase/ui/screen/profile/profile_update.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;

  const ProfileScreen({Key key, this.user, this.isAdmin, this.userModel})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil",
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: UserServices.users.doc(widget.user.uid).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text("Nama"),
                              subtitle: Text(widget.userModel.nama),
                            ),
                            ListTile(
                              title: Text("Email"),
                              subtitle: Text(widget.user.email),
                            ),
                            ListTile(
                              title: Text("Telepon"),
                              subtitle: Text(widget.userModel.telepon),
                            ),
                            ListTile(
                              title: Text("Jenis Kelamin"),
                              subtitle: Text(widget.userModel.jenisKelamin),
                            ),
                            ListTile(
                              title: Text("Tempat, Tanggal Lahir"),
                              subtitle:
                                  Text(widget.userModel.tempatTanggalLahir),
                            ),
                          ],
                        );
                      }
                      DocumentSnapshot d = snapshot.data;
                      UserModel model = UserModel.toMaps(d);
                      return Column(
                        children: [
                          ListTile(
                            title: Text("Nama"),
                            subtitle: Text(model.nama),
                          ),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text(widget.user.email),
                          ),
                          ListTile(
                            title: Text("Telepon"),
                            subtitle: Text(model.telepon),
                          ),
                          ListTile(
                            title: Text("Jenis Kelamin"),
                            subtitle: Text(model.jenisKelamin),
                          ),
                          ListTile(
                            title: Text("Tempat, Tanggal Lahir"),
                            subtitle: Text(model.tempatTanggalLahir),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            height: 40,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            minWidth:
                                MediaQuery.of(context).size.width * (1 / 2),
                            color: peach,
                            child: Text(
                              "Ubah Profil",
                              style: TextStyle(
                                color: tuatara,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              Get.to(
                                ProfileUpdateScreen(
                                  isAdmin: widget.isAdmin,
                                  user: widget.user,
                                  userModel: model,
                                ),
                                transition: Transition.fadeIn,
                              );
                            },
                          ),
                          MaterialButton(
                            height: 40,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            minWidth:
                                MediaQuery.of(context).size.width * (1 / 2),
                            color: peach,
                            child: Text(
                              "Ubah Password",
                              style: TextStyle(
                                color: tuatara,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              Get.to(
                                ChangePasswordScreen(
                                  isAdmin: widget.isAdmin,
                                  user: widget.user,
                                  userModel: model,
                                ),
                                transition: Transition.fadeIn,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  MaterialButton(
                    height: 40,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                    minWidth: MediaQuery.of(context).size.width * (1 / 2),
                    color: peach,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: tuatara,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () async {
                      Alert(
                        context: context,
                        title: "Logout",
                        type: AlertType.warning,
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Ya",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await UserServices.signOut();
                              Get.back();
                            },
                            color: turquoise,
                          ),
                          DialogButton(
                            child: Text("Tidak"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ).show();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
