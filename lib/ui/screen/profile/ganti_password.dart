import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangePasswordScreen extends StatefulWidget {
  final UserModel userModel;
  final User user;
  final bool isAdmin;

  const ChangePasswordScreen({Key key, this.userModel, this.user, this.isAdmin})
      : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _password;
  bool _isLoading = false;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Password",
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
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      title: Text("Password Baru"),
                      subtitle: TextFormField(
                        obscureText: true,
                        onSaved: (newValue) {
                          _password = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Mengubah password, anda akan melakukan login kembali",
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                              "Ubah Password",
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
                            await UserServices.changePassword(
                              password: _password,
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
                              desc: "Gagal Mengubah Password",
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
