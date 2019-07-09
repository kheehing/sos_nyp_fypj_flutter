import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => new _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  List<dynamic> dataList = [];
  StreamController streamController;
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: dashBoard(),
    );
  }

  dashBoard() {
    return Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 50),
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Statistics')),
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('help.current')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData == false) {
                        return SplashScreen();
                      } else if (snapshot.connectionState ==
                              ConnectionState.none ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return SplashScreen();
                      } else
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => _buildListItem(
                              context, snapshot.data.documents[index]),
                        );
                    }),
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('help.attended')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return SplashScreen();
                      } else
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) => _buildListItem(
                                context, snapshot.data.documents[index]));
                    }),
              ],
            )),
        TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.insert_chart)),
            Tab(icon: Icon(Icons.live_help)),
            Tab(icon: Icon(Icons.help)),
          ],
          controller: _tabController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  Future<Stream> getData() async {
    Stream stream1 = Firestore.instance.collection('user.attended').snapshots();
    Stream stream2 = Firestore.instance.collection('user.current').snapshots();
    return StreamGroup.merge([stream1, stream2]).asBroadcastStream();
  }

  @override
  void initState() {
    streamController = StreamController.broadcast();
    setupData();
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  setupData() async {
    Stream stream = await getData()
      ..asBroadcastStream();
    stream.listen((data) {
      setState(() {
        dataList.add(data[0]);
        dataList.add(data[1]);
      });
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
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
      Widget _displayAttended() {
        if (document['type'] == 'attended') {
          return Column(children: <Widget>[
            Text(
                'Called Time: ' +
                    DateFormat('K:mm:ss a').format(document['time'].toDate()),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
            Text(
                'Assisted Time: ' +
                    DateFormat('K:mm:ss a')
                        .format(document['time attended'].toDate()),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
            Text('Assisted by: ' + document['helper'],
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
          ]);
        } else
          return SizedBox();
      }

      Widget _displayCurrent() {
        if (document.data['type'] == 'help') {
          return Column(children: <Widget>[
            Text('Location',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
            Row(children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text(document['latitude'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'black_label')))),
              Expanded(
                  child: Center(
                      child: Text(document['longitude'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'black_label')))),
            ]),
            Row(children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text('latitude',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'black_label',
                              fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text('longitude',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'black_label',
                              fontWeight: FontWeight.bold)))),
            ]),
            Text('Last Requested Help',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold)),
            Text(DateFormat('kk:mm:ss a').format(document['time'].toDate()),
                style: TextStyle(fontSize: 15, fontFamily: 'black_label')),
          ]);
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
        title: document['user.name'] + ' (' + document['user.admin'] + ')',
        desc: document['user.course'] + ' (' + document['user.school'] + ')',
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
        ],
        content: Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: Row(children: <Widget>[
                  Text('Sex: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold)),
                  Text(document['user.gender'],
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 12, fontFamily: 'black_label')),
                ])),
                Expanded(
                    child: Row(children: <Widget>[
                  Text('Mobile: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold)),
                  Text(document['user.mobile'],
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 12, fontFamily: 'black_label')),
                ])),
              ]),
              _displayAttended(),
              _displayCurrent(),
            ],
          ),
        ),
      ).show();
    }

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(document['user.name'],
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.w900)),
          ),
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
        _openMap();
      },
    );
  }
}
