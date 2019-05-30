// Don't rename this file!
import 'package:flutter/material.dart';
import 'fun/testconfb.dart';  //TestPage()
import 'fun/home.dart';       //HomePage()
import 'fun/login.dart';      //LoginPage()
void main() {
  runApp(MaterialApp(
    home: new LoginPage(),
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new HomePage(),
      '/Login': (BuildContext context) => new LoginPage(),
      '/Test':(BuildContext context) => new TestPage(),
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

