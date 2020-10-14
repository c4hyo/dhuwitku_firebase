import 'package:dhuwitku_firebase/network/firebase/money.dart';
import 'package:dhuwitku_firebase/network/model/money_model.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MoneyEditScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final String idMoney;
  final MoneyModel moneyModel;

  const MoneyEditScreen(
      {Key key, this.user, this.isAdmin, this.idMoney, this.moneyModel})
      : super(key: key);

  @override
  _MoneyEditScreenState createState() => _MoneyEditScreenState();
}

class _MoneyEditScreenState extends State<MoneyEditScreen> {
  bool _isLoading = false;
  String _nama, _deskripsi, _jenis;
  int _nominal;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: turquoise,
        centerTitle: true,
        title: Text(
          "Ubah Data",
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
                        initialValue: widget.moneyModel.nama,
                        onSaved: (value) {
                          _nama = value;
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jenis ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _jenis,
                            iconSize: 24,
                            elevation: 16,
                            hint: Text(widget.moneyModel.jenis),
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _jenis = newValue;
                              });
                            },
                            items: <String>[
                              'Pengeluaran',
                              'Pemasukan',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.moneyModel.nominal.toString(),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _nominal = int.parse(value);
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null || value == "") {
                            return "Nominal tidak boleh kosong";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          labelText: "Nominal",
                          prefixText: "Rp. ",
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
                        initialValue: widget.moneyModel.deskripsi,
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
                                "Simpan Catatan",
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
                              MoneyModel money = MoneyModel(
                                deskripsi: _deskripsi,
                                jenis: (_jenis == null)
                                    ? widget.moneyModel.jenis
                                    : _jenis,
                                kategori: "",
                                nama: _nama,
                                nominal: _nominal,
                              );
                              await MoneyService.updateMoney(
                                model: money,
                                user: widget.user,
                                idMoney: widget.idMoney,
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
                                desc: "Gagal Mengubah Catatan",
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
