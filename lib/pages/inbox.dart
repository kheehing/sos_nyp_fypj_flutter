import 'dart:async';
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

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => new _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  Stream<QuerySnapshot> helpCurrent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Inbox'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
          stream: helpCurrent,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return loadingScreen();
            }
            return ListView.builder(
                // itemExtent: 80,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    buildListItem(context, snapshot.data.documents[index]));
          }),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    TextEditingController _controllerName = new TextEditingController();
    Future<dynamic> _getProfile(user) async {
      DocumentSnapshot querySnapshot =
          await Firestore.instance.collection("profile").document(user).get();
      Map<String, dynamic> jsonString = querySnapshot.data;
      final jsonRespone = json.encode(jsonString.toString());
      return jsonRespone;
    }

    Firestore.instance
        .collection('profile')
        .document(document['user'].toString())
        .get()
        .then((data) {
      setState(() async {
        String _name = await data['name'];
        _controllerName.text = _name;
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

    void _showDialog() async {
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
        desc:
            "Sex: $gender \nMobile: $mobile \nSchool: $school \nCourse: $course",
        buttons: [
          DialogButton(
              child: Text(
                'Location',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => _openMap().whenComplete(() {
                    Navigator.pop(context);
                  }),
              color: Colors.blue),
          DialogButton(
              child: Text(
                'Help',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => _openMap().whenComplete(() {
                    Navigator.pop(context);
                  }),
              color: Colors.green),
        ],
      ).show();
    }

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _controllerName,
            enabled: false,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'black_label',
                fontWeight: FontWeight.w900),
          )),
          Container(
            width: 180,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  DateFormat('dd MMM yyyy K:mm:ss a').format(document['time']),
                  style: Theme.of(context).textTheme.body1,
                )),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        _showDialog();
      },
      onLongPress: () {
        _openMap();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    helpCurrent = Firestore.instance.collection('help.current').snapshots();
  }
}
