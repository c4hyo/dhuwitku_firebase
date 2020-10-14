import 'package:dhuwitku_firebase/network/firebase/note.dart';
import 'package:dhuwitku_firebase/network/model/money_model.dart';
import 'package:dhuwitku_firebase/network/model/note_model.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/ui/screen/money/money_edit.dart';
import 'package:dhuwitku_firebase/ui/screen/note/note_edit.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:dhuwitku_firebase/utilities/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget cardNote({
  NoteModel note,
  User user,
  bool isAdmin,
  UserModel userModel,
}) {
  return Card(
    color: (note.isPin) ? spearmint : peach,
    child: ExpansionTile(
      leading: IconButton(
        icon: Icon(
          (note.isPin) ? Ionicons.ios_checkbox : Ionicons.ios_remove,
          color: tuatara,
        ),
        onPressed: () async {
          await NoteServices.pinNote(
            model: note,
            user: user,
          );
        },
      ),
      title: Text(
        note.judul.toUpperCase(),
        style: TextStyle(
          color: tuatara,
          fontSize: 17,
        ),
      ),
      childrenPadding: EdgeInsets.all(10),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.topLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat("d MMMM yyyy  H::m::s", "id_ID").format(
                DateTime.parse(note.waktuBuat),
              ),
            ),
            IconButton(
              icon: Icon(FontAwesome.edit),
              onPressed: () {
                Get.to(
                  NoteEditScreen(
                    isAdmin: isAdmin,
                    user: user,
                    userModel: userModel,
                    noteModel: note,
                  ),
                  transition: Transition.fadeIn,
                );
              },
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Keterangan: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(note.deskripsi),
      ],
    ),
  );
}

Widget cardMoney({
  MoneyModel money,
  User user,
  bool isAdmin,
  UserModel userModel,
}) {
  return Card(
    color: (money.jenis == "Pengeluaran") ? spearmint : peach,
    child: ExpansionTile(
      leading: Icon(
        (money.jenis == "Pengeluaran")
            ? FontAwesome.arrow_circle_left
            : FontAwesome.arrow_circle_right,
        color: tuatara,
      ),
      title: Text(
        money.nama.toUpperCase(),
        style: TextStyle(
          color: tuatara,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        rupiah(nominal: money.nominal),
        style: TextStyle(color: tuatara),
      ),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.all(10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jenis: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(money.jenis),
              ],
            ),
            IconButton(
              icon: Icon(FontAwesome.edit),
              onPressed: () {
                Get.to(
                  MoneyEditScreen(
                    idMoney: money.uid,
                    isAdmin: isAdmin,
                    moneyModel: money,
                    user: user,
                  ),
                );
              },
            ),
          ],
        ),
        Text(
          "Deskripsi: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(money.deskripsi),
      ],
    ),
  );
}
