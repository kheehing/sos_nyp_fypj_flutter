import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
import 'dart:async';

class HomeAdminPage extends StatefulWidget {
  final String title;
  const HomeAdminPage({Key key, this.title}) : super(key: key);

  @override
  _HomeAdminPageState createState() => new _HomeAdminPageState();
}

// Future<bool> _exitApp(BuildContext context) {
//   return showDialog(
//         context: context,
//         builder: (_) => new AlertDialog(
//               title: new Text('Exit this application?'),
//               actions: <Widget>[
//                 new FlatButton(
//                   child: new Text('No'),
//                   onPressed: () => Navigator.of(context).pop(false),
//                 ),
//                 new FlatButton(
//                   child: new Text('Yes'),
//                   onPressed: () => Navigator.of(context).pop(true),
//                 ),
//               ],
//             ),
//       ) ??
//       false;
// }

Future<String> inputData() async {
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String uid = user.uid.toString();
  return uid;
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  PermissionStatus _status;

  // @override
  void iniState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);
    // Location
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: Text('I am admin'),
    ));
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  // void _onStatusRequest(Map<PermissionGroup, PermissionStatus> statuses) {
  //   final status = statuses[PermissionGroup.locationWhenInUse];
  //   _updateStatus(status);
  //   if (status != PermissionStatus.granted) {
  //     PermissionHandler().openAppSettings();
  //   }
  // }

  // _helpButton() {
  //   PermissionHandler().requestPermissions(
  //       [PermissionGroup.locationWhenInUse]).then(_onStatusRequest);

  //   print(currentUser);
  // }
}
