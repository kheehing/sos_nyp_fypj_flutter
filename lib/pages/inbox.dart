import 'dart:async';
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

    Future<void> updateHelper() async {
      final DocumentSnapshot current = await Firestore.instance
          .collection('profile')
          .document(currentUser)
          .get();
      return Firestore.instance
          .collection('help.current')
          .document(document.documentID)
          .updateData({
        'status': 'Waiting',
        'helper otw': current.data['name'],
      });
    }

    Future<void> attended() async {
      final DocumentSnapshot db = await Firestore.instance
          .collection('help.current')
          .document(document.documentID)
          .get();
      final DocumentSnapshot current = await Firestore.instance
          .collection('profile')
          .document(currentUser)
          .get();
      Navigator.of(context).pop(context);
      Firestore.instance.collection('help.attended').document().setData({
        'type': 'attended',
        'latitude': db.data['latitude'],
        'longitude': db.data['longitude'],
        'status': 'Attended',
        'helper': current['name'],
        'helper status': db.data['helper status'],
        'helper.name': current.data['name'],
        'user': db.data['user'],
        'user.name': db.data['user.name'],
        'user.course': db.data['user.course'],
        'user.school': db.data['user.school'],
        'user.gender': db.data['user.gender'],
        'user.mobile': db.data['user.mobile'],
        'user.admin': db.data['user.admin'],
        'time': db.data['time'],
        'time attended': DateTime.now()
      }).catchError((onError) {});
      Firestore.instance
          .collection('help.current')
          .document(document.documentID)
          .delete();
    }

    void _showDialog() async {
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
        title: document['user.name'],
        buttons: [],
        content: Container(
          child: Column(
            children: <Widget>[
              Text(DateFormat('kk:mm:ss a').format(document['time']),
                  style: TextStyle(
                      fontFamily: 'black_label', fontWeight: FontWeight.bold)),
              Text('Called for assistance',
                  style: TextStyle(
                      fontFamily: 'black_label', fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              DialogButton(
                  child: Text(
                    'On The Way',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    updateHelper().then((value) {
                      Navigator.of(context).pop(context);
                    });
                  }),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(
                    child: DialogButton(
                        child: Text(
                          'Location',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => _openMap().whenComplete(() {
                              Navigator.pop(context);
                            }),
                        color: Colors.blue)),
                SizedBox(width: 10),
                Expanded(
                    child: DialogButton(
                        child: Text(
                          'Helped',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          attended();
                        },
                        color: Colors.green)),
              ]),
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
            document['user.name'],
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
                  DateFormat('dd MMM yyyy  kk:mm:ss a')
                      .format(document['time']),
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
