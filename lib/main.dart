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

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//  My Pages
import 'pages/test( DB connection ).dart'; //TestPage()
import 'pages/login.dart'; //LoginPage()
import 'pages/profile.dart'; //ProfilePage()
import 'pages/home.dart'; //homePage()

// My Test Pages
// import 'Test/_Test( Swiping ).dart'; //SwipeDemoApp()

void main() {
  runApp(MaterialApp(
    home: new LoginPage(), // _handleWindowDisplay()
    initialRoute: '/',
    // Routes
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new HomePage(),
      '/Login': (BuildContext context) => new LoginPage(),
      '/Test': (BuildContext context) => new TestPage(),
      '/Profile': (BuildContext context) => new ProfilePage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new LoginPage(),
    );
  }
}

// Widget _handleWindowDisplay() {
//   return StreamBuilder(
//       stream: FirebaseAuth.instance.onAuthStateChanged,
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: Text('Loading...'),// Add animation (loading screen)
//           );
//         } else {
//           if (snapshot.hasData) {
//             return HomePage();
//           } else {
//             return LoginPage();
//           }
//         }
//       });
// } //authen

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
              Container(),
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
            Route route = MaterialPageRoute(builder: (context) => HomePage());
            Navigator.push(context, route);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {
            Navigator.of(context).pushNamed('/Profile');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            Navigator.of(context).pushNamed('/Home');
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
