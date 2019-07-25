// Flutter will find the 'main.dart' and the 'main()' function to run the program so dont rename those files.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/pages/login.dart';
import 'package:sosnyp/pages/profileUpdate.dart';
import 'package:sosnyp/functions/theme.dart';
import 'package:sosnyp/functions/main-functions.dart';
import 'package:sosnyp/pages/manage-staff.dart';
import 'package:sosnyp/pages/add-staff.dart';
import 'package:sosnyp/pages/manage-user.dart';
import 'package:sosnyp/pages/add-user.dart';

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
        case '/AddUser':
          route = FadeRoute(page: AddUserPage());
          break;
        case '/AddStaff':
          route = FadeRoute(page: AddStaffPage());
          break;
        case '/ManageUser':
          route = FadeRoute(page: ManageUserPage());
          break;
        case '/ManageStaff':
          route = FadeRoute(page: ManageStaffPage());
          break;
      }
      return route;
    },
  ));
}

enum UserType {
  admin,
  user,
  staff,
}

String currentUser, currentUserName;
UserType currentUserType;

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
