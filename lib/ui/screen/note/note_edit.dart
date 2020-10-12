import 'package:dhuwitku_firebase/network/firebase/note.dart';
import 'package:dhuwitku_firebase/network/model/note_model.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NoteEditScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;
  final NoteModel noteModel;

  const NoteEditScreen({
    Key key,
    this.user,
    this.isAdmin,
    this.userModel,
    this.noteModel,
  }) : super(key: key);
  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  bool _isLoading = false;
  String _judul, _deskripsi;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: turquoise,
        centerTitle: true,
        title: Text(
          "Ubah Catatan",
          style: TextStyle(
            color: tuatara,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: Icon(
              Ionicons.ios_remove_circle,
              color: tuatara,
              size: 40,
            ),
            onPressed: () {
              Get.back();
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
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.noteModel.judul,
                        onSaved: (value) {
                          _judul = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null || value == "") {
                            return "Judul tidak boleh kosong";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          labelText: "Judul",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.transparent,
                              width: 3,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: turquoise,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.noteModel.deskripsi,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onSaved: (value) {
                          _deskripsi = value;
                        },
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          labelText: "Deskripsi",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.transparent,
                              width: 3,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: turquoise,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: MaterialButton(
                        height: 60,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent)),
                        minWidth: double.infinity,
                        color: turquoise,
                        child: (_isLoading)
                            ? CircularProgressIndicator()
                            : Text(
                                "Ubah Catatan",
                                style: TextStyle(
                                  color: tuatara,
                                  fontSize: 20,
                                ),
                              ),
                        onPressed: () async {
                          if (_form.currentState.validate()) {
                            _form.currentState.save();
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              NoteModel note = NoteModel(
                                deskripsi: _deskripsi,
                                judul: _judul,
                              );
                              await NoteServices.updateNote(
                                idNote: widget.noteModel.uid,
                                model: note,
                                user: widget.user,
                              );
                              Get.back();
                            } catch (e) {
                              setState(() {
                                _isLoading = false;
                              });
                              Alert(
                                context: context,
                                title: "Gagal",
                                type: AlertType.error,
                                desc: "Gagal ubah catatan",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Tutup",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.red,
                                  ),
                                ],
                              ).show();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
