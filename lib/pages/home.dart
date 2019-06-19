import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

// Future<String> inputData() async {
//   final FirebaseUser user = await FirebaseAuth.instance.currentUser();
//   final String uid = user.uid.toString();
//   return uid;
// }

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
        var _documents = Firestore.instance
            .collection('help.current')
            .document(currentUser)
            .get();
        _documents.then((data) {
          if (data.data == null) {
            debugPrint(
                '########################## ADDING ##########################');
            Firestore.instance
                .collection('help.current')
                .document(currentUser)
                .setData({
              'type': 'help',
              'latitude': userLocation['latitude'].toString(),
              'longitude': userLocation['longitude'].toString(),
              'status': 'Help',
              'helper': '',
              'helper status': '',
              'user': currentUser,
              'time': DateTime.now(),
            }).catchError((onError) {});
          } else {
            debugPrint(
                '########################## UPDATING ##########################');
            Firestore.instance
                .collection('help.current')
                .document(currentUser)
                .updateData({
              'latitude': userLocation['latitude'].toString(),
              'longitude': userLocation['longitude'].toString(),
              'time': DateTime.now(),
            }).catchError((onError) {});
          }
        });
        userLocation = value;
        print('UserLocation: ' + userLocation.toString());
      });
    });
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
