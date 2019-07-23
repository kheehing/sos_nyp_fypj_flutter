import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/pages/login.dart';
import 'package:sosnyp/pages/profileUpdate.dart';
import 'package:sosnyp/functions/theme.dart';
import 'package:sosnyp/functions/main-functions.dart';
import 'package:sosnyp/pages/manage-staff.dart';
import 'package:sosnyp/pages/manage-user.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _handleWindowDisplay(),
    theme: t,
    onGenerateRoute: (RouteSettings setting) {
      var route;
      switch (setting.name) {
        case '/UpdateProfile':
          route = FadeRoute(page: UpdateProfilePage());
          break;
        case '/Add-user':
          // route = FadeRoute(page: AddStaffPage());
          break;
        case '/Add-staff':
          // route = FadeRoute(page: UpdateProfilePage());
          break;
        case '/Manage-user':
          route = FadeRoute(page: ManageUserPage());
          break;
        case '/Manage-staff':
          route = FadeRoute(page: ManageStaffPage());
          break;
      }
      return route;
    },
  ));
}

String currentUser, currentUserName, currentUserType;

Widget _handleWindowDisplay() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none ||
          snapshot.connectionState == ConnectionState.waiting) {
        return SplashScreen();
      } else if (snapshot.hasData) {
        currentUser = snapshot.data.uid;
        return CheckEnable();
      } else {
        return LoginPage();
      }
    },
  );
}
