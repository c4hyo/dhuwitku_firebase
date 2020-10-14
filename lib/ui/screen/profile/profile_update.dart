import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final UserModel userModel;
  final User user;
  final bool isAdmin;

  const ProfileUpdateScreen({Key key, this.userModel, this.user, this.isAdmin})
      : super(key: key);
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  bool _isLoading = false;
  String _nama, _telepon, _jenisKelamin, _ttl;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Profil",
          style: TextStyle(
            color: tuatara,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: turquoise,
      ),
      body: Container(
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
        child: SafeArea(
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Nama"),
                      subtitle: TextFormField(
                        initialValue: widget.userModel.nama,
                        onSaved: (newValue) {
                          _nama = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Nama tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text("Telepon"),
                      subtitle: TextFormField(
                        keyboardType: TextInputType.phone,
                        initialValue: widget.userModel.telepon,
                        onSaved: (newValue) {
                          _telepon = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Telepon tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text("Jenis Kelamin"),
                      subtitle: TextFormField(
                        initialValue: widget.userModel.jenisKelamin,
                        onSaved: (newValue) {
                          _jenisKelamin = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Jenis Kelamin harus di isi";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text("Tempat, Tanggal Lahir"),
                      subtitle: TextFormField(
                        initialValue: widget.userModel.tempatTanggalLahir,
                        onSaved: (newValue) {
                          _ttl = newValue;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      height: 60,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent)),
                      minWidth: MediaQuery.of(context).size.width,
                      color: Theme.of(context).primaryColor,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Ubah Profil",
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
                          UserModel model = UserModel(
                            jenisKelamin: _jenisKelamin,
                            nama: _nama,
                            telepon: _telepon,
                            tempatTanggalLahir: _ttl,
                          );
                          try {
                            await UserServices.updateProfil(
                              model: model,
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
                              desc: "Gagal Mengubah Profil",
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
