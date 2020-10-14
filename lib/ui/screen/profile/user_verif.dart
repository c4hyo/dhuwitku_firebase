import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifEmail extends StatefulWidget {
  final User user;
  VerifEmail({this.user});

  @override
  _VerifEmailState createState() => _VerifEmailState();
}

class _VerifEmailState extends State<VerifEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Column(
            children: [
              Text(
                "Verifikasi Email",
                style: TextStyle(color: tuatara, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
