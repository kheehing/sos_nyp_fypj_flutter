// import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
import 'dart:async';

class DashBoardPage extends StatefulWidget {
  final String title;
  const DashBoardPage({Key key, this.title}) : super(key: key);

  @override
  _DashBoardPageState createState() => new _DashBoardPageState();
}

Future<String> inputData() async {
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String uid = user.uid.toString();
  return uid;
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: Text('I am admin wakakak'),
    ));
  }
}
