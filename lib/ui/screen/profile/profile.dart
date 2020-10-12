import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
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
        backgroundColor: turquoise,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: tuatara,
              size: 40,
            ),
            onPressed: () {
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
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text("${widget.userModel.nama}"),
        ),
      ),
    );
  }
}
