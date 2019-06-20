import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sosnyp/main.dart';

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text('Exit this application?'),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('No'),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  new FlatButton(
                    child: new Text('Yes'),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ]),
      ) ??
      false;
}

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> userLocation;
  var location = new Location();
  PermissionStatus _status;

  // @override
  @override
  Widget build(BuildContext context) {
    double thisWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            leading: myLeading,
          ),
          drawer: new MyDrawer(),
          body: Align(
              alignment: Alignment(0, 1),
              child: Container(
                  height: thisWidth - 10,
                  width: thisWidth,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(thisWidth),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(thisWidth),
                    child: MaterialButton(
                        onPressed: _helpButton,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(thisWidth)),
                        child: FittedBox(
                          child: Text(
                            'HELP',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 99999,
                                color: Colors.white,
                                fontFamily: 'black_label',
                                fontWeight: FontWeight.w600),
                          ),
                          fit: BoxFit.fitWidth,
                        )),
                  ))),
        ));
  }

  void iniState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus); // Location
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
      userLocation = currentLocation;
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  _helpButton() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequest);
    _getLocation().then((value) async {
      userLocation = value;
      var data = await Firestore.instance
          .collection('help.current')
          .document(currentUser)
          .get();
      var profileData = await Firestore.instance
          .collection('profile')
          .document(currentUser)
          .get();
      if (data.data == null) {
        Firestore.instance
            .collection('help.current')
            .document(currentUser)
            .setData({
          'type': 'help',
          'latitude': value['latitude'].toString(),
          'longitude': value['longitude'].toString(),
          'status': 'Help',
          'helper': '',
          'helper otw': '',
          'user.name': profileData['name'],
          'user.admin': profileData['admin'],
          'user.course': profileData['course'],
          'user.school': profileData['school'],
          'user.gender': profileData['gender'],
          'user.mobile': profileData['mobile'],
          'user': currentUser,
          'time': DateTime.now(),
        }).catchError((onError) {});
      } else {
        Firestore.instance
            .collection('help.current')
            .document(currentUser)
            .updateData({
          'latitude': value['latitude'].toString(),
          'longitude': value['longitude'].toString(),
          'time': DateTime.now(),
        }).catchError((onError) {});
      }
    });
  }

  void _onStatusRequest(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
    if (status != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    }
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }
}
