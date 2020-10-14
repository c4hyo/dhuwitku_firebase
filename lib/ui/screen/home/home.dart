import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/ui/widget/home.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;

  const HomeScreen({Key key, this.user, this.isAdmin, this.userModel})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: turquoise,
        title: Text(
          "Dhuwitku",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: tuatara,
          ),
        ),
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
              padding: const EdgeInsets.all(15.0),
              child: (widget.isAdmin)
                  ? homeAdmin(
                      user: widget.user,
                      userModel: widget.userModel,
                    )
                  : homeUser(
                      user: widget.user,
                      userModel: widget.userModel,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
