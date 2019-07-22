import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
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
        downloadFile();

        setState(() {
          x = true;
        });
      } else if (_.data['enabled'] == false) {
        FirebaseAuth.instance.signOut();
      }
    });
    super.initState();
  }
}
