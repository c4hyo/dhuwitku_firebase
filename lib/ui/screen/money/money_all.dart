import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/money.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/money_model.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/ui/screen/money/money_add.dart';
import 'package:dhuwitku_firebase/ui/widget/card.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:dhuwitku_firebase/utilities/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MoneyAllScreen extends StatefulWidget {
  final User user;
  final bool isAdmin;
  final UserModel userModel;

  const MoneyAllScreen({Key key, this.user, this.isAdmin, this.userModel})
      : super(key: key);
  @override
  _MoneyAllScreenState createState() => _MoneyAllScreenState();
}

class _MoneyAllScreenState extends State<MoneyAllScreen> {
  String _filterTanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
  _datePick() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (date != null) {
      setState(() {
        _filterTanggal = DateFormat('yyyy-MM-dd').format(date);
      });
    } else {
      setState(() {
        _filterTanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
      });
    }
  }

  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: turquoise,
        onPressed: () {
          Get.to(
            MoneyAddScreen(
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
        leading:
            IconButton(icon: Icon(Icons.calendar_today), onPressed: _datePick),
        centerTitle: true,
        title: Text(
          "Catatan Keuangan",
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
            padding: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream: UserServices.users
                  .doc(widget.user.uid)
                  .collection("money")
                  .where("waktu_buat", isEqualTo: _filterTanggal)
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
                    MoneyModel money = MoneyModel.toMaps(d);
                    return Dismissible(
                      key: Key(money.uid),
                      background: Card(
                        color: coral,
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("HAPUS CATATAN KEUANGAN"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      await MoneyService.deleteMoney(
                                        model: money,
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
                      child: cardMoney(
                        isAdmin: widget.isAdmin,
                        money: money,
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
