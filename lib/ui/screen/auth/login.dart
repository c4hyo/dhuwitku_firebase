import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/ui/screen/auth/registrasi.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String _email, _password;
  GlobalKey<FormState> _form = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: SafeArea(
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                (_isLoading) ? LinearProgressIndicator() : SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    onSaved: (newValue) {
                      _email = newValue;
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null || value == "") {
                        return "Email tidak boleh kosong";
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Format email salah";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null || value == "") {
                        return "Password tidak boleh kosong";
                      }
                      if (value.length < 8) {
                        return "Password minimal 8 karakter";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      if (_form.currentState.validate()) {
                        _form.currentState.save();
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          await UserServices.signIn(
                            email: _email,
                            password: _password,
                          );
                        } catch (e) {
                          setState(() {
                            _isLoading = false;
                          });
                          Alert(
                            context: context,
                            title: "Gagal",
                            type: AlertType.error,
                            desc: "Gagal login",
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
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun?",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          " registrasi sekarang",
                          style: TextStyle(color: coral),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.to(
                        RegistrasiScreen(),
                        transition: Transition.fadeIn,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
