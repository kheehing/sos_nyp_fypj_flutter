//  DO NOT RENAME THIS FILE, the system will find 'main.dart' file and run it first
//==================================================================================
//  To debug the project (run the app on your emulator/phone);
//  make sure Flutter is installed and there is a path in your system environment variable(env) or u can just launch from flutter console everytime;
//  - https://flutter.dev/docs/get-started/install/windows
//  you can use Android Studio or Visual Studio code;
//  flutter doctor          check your status
//  flutter doctor -v       check your status indepth
//  make sure everything is ticked before continue;
//  locate it in ur Command Prompt(cmd) e.g.(cd C:\Users\<user>\Desktop\Flutter_SOS)
//  flutter run             run ur program
//  or u can press ctrl + f5 when using Visual Studio code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//  My Pages
import 'package:sosnyp/pages/dashBoard.dart';
import 'package:sosnyp/pages/home.dart';
import 'package:sosnyp/pages/login.dart';
import 'package:sosnyp/pages/updateprofile.dart';
import 'package:sosnyp/pages/Profile.dart';
import 'package:sosnyp/pages/setting.dart';
import 'package:sosnyp/pages/css_test.dart';

// import 'pages/_Test( Locatoin ).dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _handleWindowDisplay(),
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/Login':
          return MaterialPageRoute(builder: (context) => LoginPage());
          break;
        // case '/Home':
        //   return MaterialPageRoute(builder: (context) => HomePage());
        //   break;
        case '/Home':
          return FadeRoute(page: HomePage());
          break;
        case '/Profile':
          return FadeRoute(page: ProfilePage());
          break;
        case '/UpdateProfile':
          return SlideLeftRoute(page: UpdateProfilePage());
          break;
        case '/Dashboard':
          return FadeRoute(page: DashBoardPage());
          break;
        case '/Setting':
          return FadeRoute(page: SettingPage());
          break;
        case '/Testing':
          return FadeRoute(page: TestingPage());
          break;
      }
    },
  ));
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
        );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}

String currentUser;

Widget _handleWindowDisplay() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none ||
          snapshot.connectionState == ConnectionState.waiting) {
        return loadingScreen();
      } else if (snapshot.hasData) {
        currentUser = snapshot.data.uid;
        return HomePage();
      } else {
        return LoginPage();
      }
    },
  );
}

// ###############################################################################
// ################################### Widgets ###################################
// ###############################################################################

//  leading for AppBar
final myLeading = Builder(
  builder: (BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  },
);

//Drawer
class MyDrawer extends StatefulWidget {
  final String title;
  const MyDrawer({Key key, this.title}) : super(key: key);

  @override
  _MyDrawerState createState() => new _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
    with SingleTickerProviderStateMixin {
  TextEditingController _controllerName = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> _documents =
        Firestore.instance.collection('profile').document(currentUser).get();
    _documents.then((db) async {
      final _name = await db.data['name'];
      _controllerName.text = 'User: ' + _name;
    });

    Container _line() {
      return Container(
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            enabled: false,
          ));
    }

    ListTile _listTile(Icon icon, String title, String navigator) {
      return ListTile(
          leading: icon,
          title: Text(title),
          onTap: () {
            Navigator.popAndPushNamed(context, '/' + navigator);
          });
    }

    Widget _listTilesAdmin(BuildContext context) {
      if (currentUser == 'Sa7pRwTTNWgFks2ETFHIWJ84AIA2') {
        return Column(children: <Widget>[
          _line(),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5), child: Text('Admin')),
          _listTile(Icon(Icons.dashboard), 'DashBoard', 'Dashboard'),
        ]);
      } else
        return SizedBox(height: 0);
    }

    return Drawer(
        child: Scrollbar(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      SizedBox(height: 50),
      _listTile(Icon(Icons.home), 'Home', 'Home'),
      _listTile(Icon(Icons.face), 'Profile', 'Profile'),
      _listTile(Icon(Icons.settings), 'Setting', 'Setting'),
      _listTile(Icon(Icons.access_alarms), 'TestButton', 'Testing'),
      _listTilesAdmin(context),
      _line(),
      ListTile(
          leading: Icon(Icons.power_settings_new),
          title: Text('Logout'),
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
          }),
    ])));
  }
}

// LoadingScreen
Widget loadingScreen() {
  return new Scaffold(
      body: new Center(
          child: Stack(
    children: <Widget>[
      Container(
          margin: EdgeInsets.only(bottom: 250),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.red,
                ),
                Text(
                  'SOS APP',
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Black_label',
                  ),
                )
              ])),
      Container(
        margin: EdgeInsets.only(top: 150),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
          ),
        ]),
      ),
    ],
  )));
}
