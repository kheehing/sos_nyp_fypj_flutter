// DO NOT RENAME THIS FILE
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'pages/test( DB connection ).dart';  //TestPage()
import 'pages/login.dart';                  //LoginPage()
import 'pages/profile.dart';                //ProfilePage()

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


class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            
          ],
        ),
      ),
        appBar: new AppBar(
          // leading ICON
          leading: Builder(
            builder: (BuildContext context) {

              return IconButton(
                icon: const Icon(Icons.menu),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          
          //right side of AppBar
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.reorder),
          //     tooltip: 'Restitch it',
          //   ),
          // ],

          title: Text('Home'),
        ),
        drawer: new Drawer(
          child: new ListView(children: <Widget>[
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushNamed('/Profile');
                Route route =
                    MaterialPageRoute(builder: (context) => ProfilePage());
                Navigator.push(context, route);
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
        ));
  }
}
