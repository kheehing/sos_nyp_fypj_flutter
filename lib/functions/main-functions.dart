import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CheckEnable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckEnableState();
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

class _CheckEnableState extends State<CheckEnable> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  bool x;

  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.requestNotificationPermissions();
    return x == null
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : RootPage();
  }

  Future downloadFile() async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(currentUser);
    final imageUrl = await ref.getDownloadURL();
    setState(() {
      currentUserImageUrl = imageUrl;
    });
  }

  @override
  void initState() {
    var db =
        Firestore.instance.collection('profile').document(currentUser).get();
    db.then((_) {
      if (_.data['enabled'] == true) {
        if (_.data['accountType'].toString() == "user") {
          setState(() {
            currentUserType = UserType.user;
          });
        } else if (_.data['accountType'].toString() == "staff") {
          setState(() {
            currentUserType = UserType.staff;
          });
        } else if (_.data['accountType'].toString() == "admin") {
          setState(() {
            currentUserType = UserType.admin;
          });
        }
        downloadFile();
        setState(() {
          x = true;
        });
      } else if (_.data['enabled'] == false) {
        FirebaseAuth.instance.signOut();
      }
    });
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume : $message');
      },
    );
    _firebaseMessaging.getToken().then((token) {
      print('THIS IS THE FREAKING TOKEN: $token');
    });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }
}
