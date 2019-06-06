//  DO NOT RENAME THIS FILE, the system will find 'main.dart' file and run it first
//==================================================================================
//  To debug the project (run the app on your emulator/phone);
//  make sure Flutter is installed and there is a path in your system environment variable(env) or u can just launch from flutter console everytime;
//  you can use Android Studio or Visual Studio code;
//  flutter doctor          check your status
//  flutter doctor -v       check your status indepth
//  make sure everything is ticked before continue;
//  locate it in ur Command Prompt(cmd) e.g.(cd C:\Users\<user>\Desktop\Flutter_SOS)
//  flutter run             run ur program
//  or u can press ctrl + f5 when using Visual Studio code
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//  My Pages
import 'pages/home.dart'; //homePage()
import 'pages/login.dart'; //LoginPage()
import 'pages/profile.dart'; //ProfilePage()

// void main() => runApp(MyApp());
void main() {
  runApp(MaterialApp(
    home: _handleWindowDisplay(),
    initialRoute: '/',
    // Routes
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new HomePage(),
      '/Login': (BuildContext context) => new LoginPage(),
      '/Profile': (BuildContext context) => new ProfilePage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: _handleWindowDisplay(),
    );
  }
}

Widget _handleWindowDisplay() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                          strokeWidth: 10,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red)),
                    ),
                  ]),
            ),
          ],
        )));
      } else {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        DrawerHeader(
          child: Row(
            children: <Widget>[
              Text('test'),
              Text('test'),
              Container(),
              Container(),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed('/Home');
          },
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {
            Navigator.of(context).pushNamed('/Profile');
          },
        ),
        ListTile(
          title: Text('LogOut'),
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
          },
        ),
      ]),
    );
  }
}
