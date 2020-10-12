import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuwitku_firebase/network/firebase/user.dart';
import 'package:dhuwitku_firebase/network/model/user_mode.dart';
import 'package:dhuwitku_firebase/ui/screen/auth/login.dart';
import 'package:dhuwitku_firebase/ui/screen/home/home.dart';
import 'package:dhuwitku_firebase/ui/screen/money/money_all.dart';
import 'package:dhuwitku_firebase/ui/screen/note/note_all.dart';
import 'package:dhuwitku_firebase/ui/screen/profile/profile.dart';
import 'package:dhuwitku_firebase/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      MyApp(),
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: UserServices.checkUser,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dhuwitku",
        theme: ThemeData(
          primaryColor: coral,
          accentColor: cream,
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: cream,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CekScreen(),
      ),
    );
  }
}

class CekScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return (user == null)
        ? LoginScreen()
        : FutureBuilder<DocumentSnapshot>(
            future: UserServices.getProfil(user.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              UserModel model = UserModel.toMaps(snapshot.data);
              return Mains(
                userModel: model,
                isAdmin: model.isAdmin,
                user: user,
              );
            },
          );
  }
}

class Mains extends StatefulWidget {
  final UserModel userModel;
  final bool isAdmin;
  final User user;
  Mains({this.isAdmin, this.user, this.userModel});

  @override
  _MainsState createState() => _MainsState();
}

class _MainsState extends State<Mains> {
  int _selectTab = 0;
  List<Widget> _tabUser() => [
        HomeScreen(
          isAdmin: widget.isAdmin,
          user: widget.user,
          userModel: widget.userModel,
        ),
        NoteAllScreen(
          isAdmin: widget.isAdmin,
          user: widget.user,
          userModel: widget.userModel,
        ),
        MoneyAllScreen(
          isAdmin: widget.isAdmin,
          user: widget.user,
          userModel: widget.userModel,
        ),
        ProfileScreen(
          isAdmin: widget.isAdmin,
          user: widget.user,
          userModel: widget.userModel,
        ),
      ];
  List<Widget> _tabAdmin() => [
        HomeScreen(
          isAdmin: widget.isAdmin,
          user: widget.user,
          userModel: widget.userModel,
        ),
        Text("User"),
        Text("Category"),
        ProfileScreen(
          isAdmin: widget.isAdmin,
          user: widget.user,
          userModel: widget.userModel,
        ),
      ];
  List<BottomNavigationBarItem> _bnbUser = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("Beranda"),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesome.sticky_note),
      title: Text("Note"),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesome.money),
      title: Text("Money"),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesome.user_circle),
      title: Text("Profil"),
    ),
  ];
  List<BottomNavigationBarItem> _bnbAdmin = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("Beranda"),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesome.users),
      title: Text("Users"),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesome.tags),
      title: Text("Categories"),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesome.user_circle),
      title: Text("Profil"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final List<Widget> _list = (widget.isAdmin) ? _tabAdmin() : _tabUser();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: cream,
        items: (widget.isAdmin) ? _bnbAdmin : _bnbUser,
        currentIndex: _selectTab,
        iconSize: 40,
        unselectedItemColor: turquoise,
        selectedItemColor: tuatara,
        onTap: (value) {
          setState(() {
            _selectTab = value;
          });
        },
      ),
      body: SafeArea(child: _list[_selectTab]),
    );
  }
}
