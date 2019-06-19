import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sosnyp/main.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => new _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List current;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      child: Scaffold(
        drawer: new MyDrawer(),
        appBar: AppBar(
          title: Text('DashBoard'),
          leading: myLeading,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Statistics')),
              Tab(child: Text('Current')),
              Tab(child: Text('Attended')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Statistics')),
            StreamBuilder(
                stream:
                    Firestore.instance.collection('help.current').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) return loadingScreen();
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  );
                }),
            StreamBuilder(
                stream:
                    Firestore.instance.collection('help.attended').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return loadingScreen();
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  );
                }),
          ],
        ),
      ),
      length: 3,
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (!document.exists) {
      return loadingScreen();
    }
    TextEditingController _controllerName = new TextEditingController();
    TextEditingController _controllerNameDialog = new TextEditingController();

    Firestore.instance
        .collection('profile')
        .document(document['user'].toString())
        .get()
        .then((data) {
      setState(() async {
        String _name = await data['name'];
        _controllerName.text = _name;
        _controllerNameDialog.text = _name + ' Details';
      });
    });

    _openMap() async {
      final String _long = await document['longitude'];
      final String _lan = await document['latitude'];
      // Android
      var url = 'https://www.google.com/maps/search/?api=1&query=$_lan,$_long';
      if (Platform.isIOS) {
        // iOS
        url = 'http://maps.apple.com/?ll=$_lan,$_long';
      }
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<dynamic> _getProfile(user) async {
      DocumentSnapshot querySnapshot =
          await Firestore.instance.collection("profile").document(user).get();
      Map<String, dynamic> jsonString = querySnapshot.data;
      final jsonRespone = json.encode(jsonString.toString());
      return jsonRespone;
    }

    void _showDialog() async {
      // final DocumentSnapshot dbCurrent = await Firestore.instance
      //     .collection('help.current')
      //     .document(document.documentID)
      //     .get();
      // final DocumentSnapshot dbAttended = await Firestore.instance
      //     .collection('help.attended')
      //     .document(document.documentID)
      //     .get();
      var _data = await _getProfile(document['user'].toString());
      int genderI = _data.indexOf('gender');
      int schoolI = _data.indexOf('school');
      int mobileI = _data.indexOf('mobile');
      int nameI = _data.indexOf('name');
      int adminI = _data.indexOf('admin');
      int courseI = _data.indexOf('course');
      int endI = _data.indexOf('}');
      final String gender = _data.substring(genderI + 8, schoolI - 2);
      final String school = _data.substring(schoolI + 8, mobileI - 2);
      final String mobile = _data.substring(mobileI + 8, nameI - 2);
      final String name = _data.substring(nameI + 6, adminI - 2);
      final String admin = _data.substring(adminI + 7, courseI - 2);
      final String course = _data.substring(courseI + 8, endI);
      // print(gender + school + mobile + name + admin + course + _data);
      Widget _displayAttended() {
        if (document['type'] == 'attended') {
          return Column(children: <Widget>[
            Text(
                'Called Time: ' +
                    DateFormat('K:mm:ss a').format(document['time']),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
            Text(
                'Assisted Time: ' +
                    DateFormat('K:mm:ss a').format(document['time attended']),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
          ]);
        } else
          return SizedBox();
      }

      _displayCurrent() {
        if (document.data['type'] == 'help') {
          return SizedBox();
        } else
          return SizedBox();
      }

      Alert(
        style: AlertStyle(
          animationType: AnimationType.fromBottom,
          isCloseButton: false,
          isOverlayTapDismiss: true,
          descStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'black_label',
              fontWeight: FontWeight.w900),
          animationDuration: Duration(milliseconds: 50),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.white,
            ),
          ),
          titleStyle: TextStyle(
              fontSize: 20,
              fontFamily: 'black_label',
              fontWeight: FontWeight.w900),
        ),
        context: context,
        // type: AlertType.warning,
        title: "$name\n$admin",
        desc: "School: $school \n$course",
        buttons: [],
        content: Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: Text('Sex: $gender',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('Mobile: $mobile',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.bold))),
              ]),
              _displayAttended(),
              _displayCurrent(),
              SizedBox(height: 10),
              DialogButton(
                  child: Text(
                    'Location',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => _openMap().whenComplete(() {
                        Navigator.pop(context);
                      }),
                  color: Colors.blue),
            ],
          ),
        ),
      ).show();
    }

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                  controller: _controllerName,
                  enabled: false,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'black_label',
                      fontWeight: FontWeight.w900))),
          Container(
            width: 180,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    document['latitude'].toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                Expanded(
                  child: Text(
                    document['longitude'].toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        _showDialog();
      },
      onLongPress: () {
        _showDialog();
      },
    );
  }
}
