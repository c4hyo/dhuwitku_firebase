import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrasiScreen extends StatefulWidget {
  @override
  _RegistrasiScreenState createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  bool _isLoading = false;
  String _email, _password, _nama;
  GlobalKey<FormState> _form = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrasi Screen"),
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
                      _nama = newValue;
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null || value == "") {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Nama",
                    ),
                  ),
                ),
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
                      labelText: "Email",
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
                      labelText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text("Registrasi"),
                    onPressed: () async {
                      if (_form.currentState.validate()) {
                        _form.currentState.save();
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          await UserServices.signup(
                            email: _email,
                            nama: _nama,
                            password: _password,
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
                            desc: "Gagal registrasi",
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
    );
  }
}
