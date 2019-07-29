import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
    String userDetailsImageUrl;

    if (document.data == null) {
      return CircularProgressIndicator();
    } else {
      Map<dynamic, dynamic> userDetails = document.data['user.details'];
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

        Future<void> updateHelper() async {
          return Firestore.instance
              .collection('help.current')
              .document(document.documentID)
              .updateData({
            'helper': {
              'otw': currentUserName,
              'status': 'otw',
            }
          });
        }

        Future<void> attended() async {
          final DocumentSnapshot db = await Firestore.instance
              .collection('help.current')
              .document(document.documentID)
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
            'user.details': db.data['user.details'],
          }, merge: true).catchError((onError) {});
          Firestore.instance
              .collection('help.current')
              .document(document.documentID)
              .delete();
        }

        void _showDialog() async {
          final DocumentSnapshot db = await Firestore.instance
              .collection('help.current')
              .document(document.documentID)
              .get();
          String user = await db.data['user'];
          final StorageReference ref =
              FirebaseStorage.instance.ref().child('details/' + user);
          final imageUrl = await ref.getDownloadURL();
          setState(() {
            userDetailsImageUrl = imageUrl;
          });
          Alert(
            image: userDetailsImageUrl == null
                ? Image(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png'))
                : Image(
                    image: NetworkImage(
                    userDetailsImageUrl,
                  )),
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
            title: userDetails['name'],
            buttons: [],
            content: Container(
              child: Column(
                children: <Widget>[
                  Text(
                      DateFormat("hh:mm:ss a")
                          .format(document['time'].toDate()),
                      style: TextStyle(
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () => launch("tel://${userDetails['mobile']}"),
                    child: Text("Call User: ${userDetails['mobile']}",
                        style: TextStyle(
                          color: Color(0xff5d74e3),
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                  DialogButton(
                      height: ScreenUtil.getInstance().setHeight(100),
                      child: Text(
                        'I\'m On The Way',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        updateHelper().then((value) {
                          Navigator.of(context, rootNavigator: true).pop();
                        });
                      }),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
                  Container(
                      height: ScreenUtil.getInstance().setHeight(100),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: DialogButton(
                                height: ScreenUtil.getInstance().setHeight(100),
                                child: Icon(
                                  Icons.my_location,
                                  color: Colors.white,
                                  size: ScreenUtil.getInstance().setSp(80),
                                ),
                                onPressed: () => _openMap().whenComplete(() {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    }),
                                color: Colors.blue)),
                        SizedBox(width: ScreenUtil.getInstance().setHeight(10)),
                        Expanded(
                            child: DialogButton(
                                height: ScreenUtil.getInstance().setHeight(100),
                                child: Text(
                                  'I Assisted',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  attended();
                                },
                                color: Colors.green)),
                      ])),
                ],
              ),
            ),
          ).show();
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
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      new DateFormat("dd MMM yyyy hh:mm:ss")
                          .format(document['time'].toDate()),
                      maxLines: 1,
                      style: TextStyle(
                        wordSpacing: ScreenUtil.getInstance().setSp(1),
                      ),
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
    }
  }

  @override
  void initState() {
    super.initState();
    helpCurrent = Firestore.instance.collection('help.current').snapshots();
  }
}
