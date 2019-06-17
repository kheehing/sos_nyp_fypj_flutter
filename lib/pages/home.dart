import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('Exit this application?'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                new FlatButton(
                  child: new Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
      ) ??
      false;
}

Future<String> inputData() async {
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String uid = user.uid.toString();
  return uid;
}

class _HomePageState extends State<HomePage> {
  Map<String, double> userLocation;
  var location = new Location();
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
    double thisWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            leading: myLeading,
          ),
          drawer: new MyDrawer(),
          body: Center(
              child: Container(
                  height: thisWidth - 20,
                  width: thisWidth,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99999),
                      border: new Border.all(
                        color: Colors.red,
                        width: 10,
                      )),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Material(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(thisWidth),
                        child: MaterialButton(
                            onPressed: _helpButton,
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(thisWidth)),
                            child: Text(
                              'HELP',
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 100,
                                  color: Colors.white,
                                  fontFamily: 'black_label',
                                  fontWeight: FontWeight.w600),
                            )),
                      )))),
        ));
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  void _onStatusRequest(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
    if (status != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    }
  }

  _helpButton() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequest);
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
    print('UserLocation: ' + userLocation.toString());
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
