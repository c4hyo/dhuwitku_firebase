import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isLoading = false;
  String _email;
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: turquoise,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: new BoxDecoration(
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
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 170,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage("asset/logo.png"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Reset Password",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                      height: 60,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent)),
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: (_isLoading)
                          ? CircularProgressIndicator()
                          : Text(
                              "Reset Password",
                              style: TextStyle(
                                color: Colors.white,
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
                            await UserServices.auth.sendPasswordResetEmail(
                              email: _email,
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
                              desc: "Gagal mengirim email",
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
    );
  }
}
