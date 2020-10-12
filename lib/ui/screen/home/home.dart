import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome ${widget.userModel.nama}",
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
                    height: 30,
                  ),
                  Card(
                    color: turquoise,
                    child: ListTile(
                      title: Text("Catatan Saya"),
                      trailing: Icon(
                        FontAwesome.sticky_note,
                        size: 80,
                      ),
                      subtitle: Text(
                        "10",
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: peach,
                    child: ListTile(
                      title: Text("Catatan Keuangan"),
                      trailing: Icon(
                        FontAwesome.money,
                        size: 80,
                      ),
                      subtitle: Text(
                        "10",
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
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
