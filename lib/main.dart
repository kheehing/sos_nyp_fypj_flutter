import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/pages/login.dart';
import 'package:sosnyp/pages/profileUpdate.dart';
import 'package:sosnyp/theme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _handleWindowDisplay(),
    theme: vikingTheme(),
    onGenerateRoute: (RouteSettings setting) {
      switch (setting.name) {
        case '/UpdateProfile':
          return FadeRoute(page: UpdateProfilePage());
          break;
      }
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
        // var name = snapshot.data.toString();
        // print(name);
        // add display name
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
