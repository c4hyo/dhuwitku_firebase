import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MoneyAllScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;

  const MoneyAllScreen({Key key, this.user, this.isAdmin, this.userModel})
      : super(key: key);
  @override
  _MoneyAllScreenState createState() => _MoneyAllScreenState();
}

class _MoneyAllScreenState extends State<MoneyAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: turquoise,
        actions: [
          IconButton(
            icon: Icon(
              Ionicons.ios_add_circle,
              color: tuatara,
              size: 40,
            ),
            onPressed: () {
              print("");
            },
          )
        ],
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
        ),
      ),
    );
  }
}
