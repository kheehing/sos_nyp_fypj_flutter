import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/main.dart';

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
  bool x;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
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

  updateTokenUser(token) {
    Firestore.instance
        .collection('users')
        .document(currentUser)
        .setData({'token': token});
  }

  updateTokenStaff(token) {
    Firestore.instance
        .collection('staffs')
        .document(currentUser)
        .setData({'token': token});
  }

  @override
  void initState() {
    super.initState();
    var db =
        Firestore.instance.collection('profile').document(currentUser).get();
    db.then((_) => _firebaseMessaging.getToken().then((token) {
          if (_.data['enabled'] == true) {
            if (_.data['accountType'].toString() == "user") {
              updateTokenUser(token);
              setState(() {
                currentUserType = UserType.user;
              });
            } else if (_.data['accountType'].toString() == "staff") {
              updateTokenStaff(token);
              setState(() {
                currentUserType = UserType.staff;
              });
            } else if (_.data['accountType'].toString() == "admin") {
              updateTokenStaff(token);
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
        }));
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
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }
}
