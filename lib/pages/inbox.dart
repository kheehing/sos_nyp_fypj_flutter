import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sosnyp/functions/main-functions.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'inboxOnClick.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => new _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  Stream<QuerySnapshot> helpCurrent;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: helpCurrent,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return SplashScreen();
          }
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  buildListItem(context, snapshot.data.documents[index]));
        });
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.data == null) {
      return CircularProgressIndicator();
    } else {
      Map<dynamic, dynamic> userDetails = document.data['userdetails'];
      if (userDetails == null) {
        return CircularProgressIndicator();
      } else {
        _openMap() async {
          final String _long = await document['longitude'];
          final String _lan = await document['latitude'];
          // Android
          var url =
              'https://www.google.com/maps/search/?api=1&query=$_lan,$_long';
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

        return ListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                userDetails['name'],
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.w900),
              )),
              Container(
                width: ScreenUtil.getInstance().setWidth(350),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    document.data["helper"]["otw"] == ""
                        ? Container()
                        : Icon(Icons.directions_run),
                    document.data["details"]["block"] == ""
                        ? Container()
                        : Icon(Icons.assignment_turned_in),
                    AutoSizeText(
                        new DateFormat("hh:mm:ss a")
                            .format(document['time'].toDate()),
                        maxLines: 1,
                        style: TextStyle(
                          wordSpacing: ScreenUtil.getInstance().setSp(1),
                        )),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            // _showDialog();
            _showInboxOnClickPage(document, userDetails['name'],
                userDetails['mobile'], document['time'].toDate());
          },
          onLongPress: () {
            _openMap();
          },
        );
      }
    }
  }

  _showInboxOnClickPage(document, usersname, number, datetime) async {
    final DocumentSnapshot db = await Firestore.instance
        .collection('help.current')
        .document(document.documentID)
        .get();
    String user = await db.data['user'];
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('details/' + user);
    final imageUrl = await ref.getDownloadURL();
    Navigator.of(context).push(FadeRoute(
        page: InboxOnClickPage(
      title: usersname,
      imageUrl: imageUrl,
      phoneNumber: number,
      datetime: datetime,
      long: document['longitude'],
      lat: document['latitude'],
      document: document,
    )));
  }

  @override
  void initState() {
    super.initState();
    helpCurrent = Firestore.instance.collection('help.current').snapshots();
  }
}
