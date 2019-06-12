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
//  My Pages
import 'package:sosnyp/pages/dashBoard.dart';
import 'package:sosnyp/pages/home.dart';
import 'package:sosnyp/pages/login.dart';
import 'package:sosnyp/pages/updateprofile.dart';
import 'package:sosnyp/pages/Profile.dart';

void main() {
  runApp(MaterialApp(
    home: _handleWindowDisplay(),
    initialRoute: '/',
    // Routes
    routes: <String, WidgetBuilder>{
      '/Dashboard': (BuildContext context) => new DashBoardPage(),
      '/Home': (BuildContext context) => new HomePage(),
      '/Login': (BuildContext context) => new LoginPage(),
      '/Profile': (BuildContext context) => new ProfilePage(),
      '/UpdateProfile': (BuildContext context) => new UpdateProfilePage(),
    },
  ));
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

//  Drawer
class MyDrawer extends StatelessWidget {
// final GlobalKey<MyDrawer> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ListTile _drawerTile(String route, String userType) {
      var listtile;
      if (userType == 'admin') {
        if (currentUser == 'Sa7pRwTTNWgFks2ETFHIWJ84AIA2') {
          listtile = ListTile(
              title: Text(route),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/' + route);
              });
        }
      } else if (userType == 'all') {
        listtile = ListTile(
            title: Text(route),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/' + route);
            });
      }
      return listtile;
    }

    // @override
    // Widget build(BuildContext context) {
    //   return StreamBuilder<QuerySnapshot>(
    //     stream: Firestore.instance.collection('profile').snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

    //     },
    //   );
    // }

    return Drawer(
        child: Scrollbar(
      child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 100),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 20,
                        )
                      ]),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.fromLTRB(7, 4, 10, 10),
                child: Column(
                  children: <Widget>[
                    Container(),
                    Text(
                      'test',
                    ),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                  ],
                ),
              ),
            ],
          ),
          RaisedButton(
              child: Text('Home'),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/Home');
              }),
          RaisedButton(
              child: Text('Profile'),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/Profile');
              }),
          RaisedButton(
              child: Text('LogOut'),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              })
        ],
      ),
    )

        // ListView(children: <Widget>[
        //   DrawerHeader(
        //     child: Row(
        //       children: <Widget>[
        //         Text(currentUser),
        //       ],
        //     ),
        //     decoration: BoxDecoration(
        //       color: Colors.blue,
        //       gradient: LinearGradient(
        //         begin: Alignment.topRight,
        //         end: Alignment.bottomLeft,
        //         stops: [0, 0.25, 0.5, 0.75, 1],
        //         colors: [
        //           Colors.blue[900],
        //           Colors.blue[800],
        //           Colors.blue[700],
        //           Colors.blue[600],
        //           Colors.blue[500],
        //         ],
        //       ),
        //     ),
        //   ),
        //   // animated container
        //   // silverlist / gird ?
        //   _silverList(),
        //   _drawerTile('Dashboard', 'admin'),
        //   _drawerTile('Home', 'all'),
        //   _drawerTile('Profile', 'all'),
        //   ListTile(
        //       title: Text('LogOut'),
        //       onTap: () {
        //         FirebaseAuth.instance.signOut().then((value) {
        //           Navigator.of(context).popUntil((route) => route.isFirst);
        //         });
        //       }),
        // ]),
        );
  }
}

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
