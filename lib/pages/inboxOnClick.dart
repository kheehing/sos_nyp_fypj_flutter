import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sosnyp/functions/theme.dart';
import 'package:sosnyp/main.dart';
import 'package:url_launcher/url_launcher.dart';

class InboxOnClickPage extends StatefulWidget {
  final DocumentSnapshot document;
  final String title;
  final String imageUrl;
  final String phoneNumber;
  final DateTime datetime;
  final String long;
  final String lat;
  const InboxOnClickPage(
      {Key key,
      this.title,
      this.imageUrl,
      this.phoneNumber,
      this.datetime,
      this.long,
      this.lat,
      this.document})
      : super(key: key);

  @override
  _InboxOnClickPageState createState() => new _InboxOnClickPageState();
}

class _InboxOnClickPageState extends State<InboxOnClickPage> {
  _openMap() async {
    final String _long = widget.long;
    final String _lan = widget.lat;
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

  Future<void> attended() async {
    final DocumentSnapshot db = await Firestore.instance
        .collection('help.current')
        .document(widget.document.documentID)
        .get();
    Map<dynamic, dynamic> helper = await db.data['helper'];
    Navigator.of(context, rootNavigator: true).pop();
    Firestore.instance.collection('help.attended').document().setData({
      'details': db.data['details'],
      'helper': {
        'otw': helper['otw'],
        'status': helper['status'],
        'helper': currentUserName,
      },
      'latitude': db.data['latitude'],
      'longitude': db.data['longitude'],
      'status': 'attended',
      'time': db.data['time'],
      'time attended': DateTime.now(),
      'type': 'attended',
      'user': db.data['user'],
      'userdetails': db.data['userdetails'],
    }, merge: true).catchError((onError) {});
    Firestore.instance
        .collection('help.current')
        .document(widget.document.documentID)
        .delete();
  }

  Future<void> updateHelper() async {
    return Firestore.instance
        .collection('help.current')
        .document(widget.document.documentID)
        .updateData({
      'helper': {
        'otw': currentUserName,
        'status': 'otw',
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? "Actions" : widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            widget.imageUrl == null
                ? Image(
                    height: 200,
                    width: 200,
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png'))
                : Image(
                    height: 450,
                    width: 400,
                    image: NetworkImage(
                      widget.imageUrl,
                    )),
            Container(
              height: 28,
              child: GestureDetector(
                  onTap: () => launch("tel://${widget.phoneNumber}"),
                  child: AutoSizeText(
                      "call ${widget.title} : ${widget.phoneNumber}",
                      maxLines: 1,
                      style: TextStyle(
                          color: Color(0xFF5d74e3),
                          decoration: TextDecoration.underline,
                          fontSize: 24))),
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      "Date: ${DateFormat("dd MMM yyyy").format(widget.datetime)}"),
                  Text(
                      "Time: ${DateFormat("hh:mm:ss a").format(widget.datetime)}"),
                ]),
            SizedBox(height: 10),
            RaisedButton(
                color: tCelestialBlue,
                onPressed: () => {
                      updateHelper().then((value) {
                        Navigator.of(context, rootNavigator: true).pop();
                      })
                    },
                child: AutoSizeText(
                  'I\'m on the way',
                  maxLines: 1,
                  style: TextStyle(fontSize: 24),
                )),
            widget.document.data["helper"]["otw"] == ""
                ? Container()
                : Text("Staff OTW: ${widget.document.data["helper"]["otw"]}"),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      color: tCelestialBlue,
                      onPressed: () => _openMap().whenComplete(() {
                            Navigator.of(context, rootNavigator: true).pop();
                          }),
                      child: AutoSizeText(
                        'Map',
                        maxLines: 1,
                        style: TextStyle(fontSize: 24),
                      )),
                  RaisedButton(
                      color: Colors.green,
                      onPressed: () => {attended()},
                      child: AutoSizeText(
                        'Assisted',
                        maxLines: 1,
                        style: TextStyle(fontSize: 24),
                      )),
                ]),
          ],
        ),
      ),
    );
  }
}
