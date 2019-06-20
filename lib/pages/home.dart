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
    StreamBuilder _getDB() {
      return StreamBuilder(
          stream: Firestore.instance
              .collection('help.current')
              .document(currentUser)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return loadingScreen();
            return _buildItem(context, snapshot.data);
          });
    }

    double thisWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            leading: myLeading,
          ),
          drawer: new MyDrawer(),
          body: Stack(children: <Widget>[
            _getDB(),
            Align(
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
                        child: GestureDetector(
                          onLongPress: () {
                            print('lol');
                          },
                          child: MaterialButton(
                              onPressed: _helpButton,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(thisWidth)),
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
                        )))),
          ]),
        ));
  }

  void iniState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus); // Location
  }

  Widget _buildItem(BuildContext context, DocumentSnapshot document) {
    if (document.data == null) {
      return Align(
        alignment: Alignment(0, -1),
        child: Container(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
              )
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('Current Status:\nNormal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 99,
                      color: Colors.white,
                      // fontFamily: 'black_label',
                    )),
              ),
            ),
          ),
        ),
      );
    }

    BoxDecoration _dashBoardDeco1() {
      switch (document.data['status']) {
        case 'Help':
          return BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
              )
            ],
          );
          break;
        case 'Waiting':
          return BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
              )
            ],
          );
          break;
        default:
          return BoxDecoration();
      }
    }

    Text _dashBoardText() {
      switch (document.data['status']) {
        case 'Help':
          return Text('Current Status:\nSeeking Help',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 99, color: Colors.white));
          break;
        case 'Waiting':
          return Text('Current Status:\nStaff is on the Way',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 99, color: Colors.white));
          break;
        default:
          return Text('');
      }
    }

    return Align(
      alignment: Alignment(0, -1),
      child: Container(
        height: MediaQuery.of(context).size.width / 2,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: _dashBoardDeco1(),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: _dashBoardText(),
            ),
          ),
        ),
      ),
    );
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
