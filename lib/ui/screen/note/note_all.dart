import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/note.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/note_model.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/ui/screen/note/note_add.dart';
import 'package:dhuwitku_firebase/ui/widget/card.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:dhuwitku_firebase/utilities/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoteAllScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;

  const NoteAllScreen({Key key, this.user, this.isAdmin, this.userModel})
      : super(key: key);
  @override
  _NoteAllScreenState createState() => _NoteAllScreenState();
}

class _NoteAllScreenState extends State<NoteAllScreen> {
  String _filterTanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: turquoise,
        onPressed: () {
          Get.to(
            NoteAddScreen(
              isAdmin: widget.isAdmin,
              user: widget.user,
              userModel: widget.userModel,
            ),
            transition: Transition.fadeIn,
          );
        },
        child: Icon(
          Ionicons.ios_add,
          color: tuatara,
          size: 40,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Semua Catatan",
          style: TextStyle(
            color: tuatara,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: turquoise,
        bottom: PreferredSize(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tglIndo(tanggal: _filterTanggal),
                  style: TextStyle(
                    color: tuatara,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(30),
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: StreamBuilder<QuerySnapshot>(
              stream: UserServices.users
                  .doc(widget.user.uid)
                  .collection("note")
                  .orderBy("is_pin", descending: true)
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
                    NoteModel note = NoteModel.toMaps(d);
                    return Dismissible(
                      key: Key(note.uid),
                      background: Card(
                        color: coral,
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("HAPUS CATATAN"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      await NoteServices.deleteNote(
                                        model: note,
                                        user: widget.user,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("YA")),
                                FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("TIDAK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: cardNote(
                        isAdmin: widget.isAdmin,
                        note: note,
                        user: widget.user,
                        userModel: widget.userModel,
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
