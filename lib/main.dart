import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/pages/login.dart';
import 'package:sosnyp/pages/profileUpdate.dart';
import 'package:sosnyp/functions/theme.dart';

// import 'package:sosnyp/testing/testing.dart';
// void main() => runApp(MyApp());

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: MyApp(),
    home: _handleWindowDisplay(),
    theme: t,
    onGenerateRoute: (RouteSettings setting) {
      var tis;
      switch (setting.name) {
        case '/UpdateProfile':
          tis = FadeRoute(page: UpdateProfilePage());
          break;
      }
      return tis;
    },
  ));
}

String currentUser, currentUserName;

Widget _handleWindowDisplay() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none ||
          snapshot.connectionState == ConnectionState.waiting) {
        return SplashScreen();
      } else if (snapshot.hasData) {
        currentUser = snapshot.data.uid;
        return RootPage();
      } else {
        return LoginPage();
      }
    },
  );
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
