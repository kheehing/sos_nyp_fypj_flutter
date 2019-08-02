import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  TabController _tabController;
  List<dynamic> blockFloor = new List<dynamic>();
  List<String> block = new List<String>(),
      floor = new List<String>(),
      responder = new List<String>(),
      user = new List<String>(),
      averageTimeTaken = new List<String>();
  num numCurrent, numAttended;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1350, allowFontScaling: true);
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
                _statisticsPage(),
                _streamCurrent(),
                _streamCompleted(),
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

  Widget _statisticsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: ScreenUtil.getInstance().setHeight(1100),
          width: ScreenUtil.getInstance().setWidth(750),
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(ScreenUtil.getInstance().setSp(10)),
              child: Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setHeight(5)),
                  margin: EdgeInsets.all(ScreenUtil.getInstance().setSp(10)),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(
                          ScreenUtil.getInstance().setSp(10))),
                  width: ScreenUtil.getInstance().setWidth(340),
                  child: Column(children: <Widget>[
                    Text(
                      'Current',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: ScreenUtil.getInstance().setSp(32),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      numCurrent == null ? '-' : numCurrent.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: ScreenUtil.getInstance().setSp(32),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ]),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(ScreenUtil.getInstance().setSp(10)),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setHeight(5)),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(
                          ScreenUtil.getInstance().setSp(10))),
                  width: ScreenUtil.getInstance().setWidth(340),
                  child: Column(children: <Widget>[
                    Text(
                      'Attended',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: ScreenUtil.getInstance().setSp(32),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      numAttended == null ? '-' : numAttended.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: ScreenUtil.getInstance().setSp(32),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ]),
                ),
                Container(),
              ]),
            ),
          ]),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _getStatistics();
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.data == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      Map<dynamic, dynamic> userDetails = document.data['userdetails'];
      if (userDetails == null) {
        return Center(child: CircularProgressIndicator());
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

        void _showDialog() async {
          Widget _displayAttended() {
            if (document['type'] == 'attended') {
              Map<dynamic, dynamic> helper = document.data['helper'];
              return Container(
                  height: ScreenUtil.getInstance().setHeight(250),
                  child: Column(children: <Widget>[
                    Spacer(),
                    Text(
                        'Request: ' +
                            DateFormat('K:mm:ss a')
                                .format(document['time'].toDate()),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(25)),
                    Text(
                        'Assisted: ' +
                            DateFormat('K:mm:ss a')
                                .format(document['time attended'].toDate()),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(25)),
                    Text('Assistant: ' + helper['helper'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'black_label',
                          fontWeight: FontWeight.bold,
                        )),
                    Spacer(),
                  ]));
            } else
              return SizedBox();
          }

          Widget _displayCurrent() {
            if (document.data['type'] == 'help') {
              return Container(
                  height: ScreenUtil.getInstance().setHeight(250),
                  child: Column(children: <Widget>[
                    Spacer(),
                    Text('Location',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'black_label',
                        )),
                    Row(children: <Widget>[
                      Expanded(
                          child: Center(
                              child: Text(
                        document['latitude'],
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        document['longitude'],
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ))),
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Center(
                              child: Text('latitude',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(25),
                                    fontFamily: 'black_label',
                                  )))),
                      Expanded(
                          child: Center(
                              child: Text('longitude',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(25),
                                    fontFamily: 'black_label',
                                  )))),
                    ]),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(25)),
                    Text('Last Requested Help',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'black_label',
                        )),
                    Text(
                      DateFormat('kk:mm:ss a')
                          .format(document['time'].toDate()),
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Spacer(),
                  ]));
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
            title: userDetails['name'] + ' (' + userDetails['admin'] + ')',
            desc: userDetails['course'] + ' (' + userDetails['school'] + ')',
            buttons: [
              DialogButton(
                  child: Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.getInstance().setSp(50)),
                  ),
                  onPressed: () => _openMap().whenComplete(() {
                        Navigator.of(context, rootNavigator: true).pop();
                      }),
                  color: Colors.blue),
            ],
            content: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
                  Row(children: <Widget>[
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Text('Sex: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'black_label',
                              )),
                          Text(
                            userDetails['gender'],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ])),
                  ]),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text('Mobile: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'black_label',
                            )),
                        Text(
                          userDetails['mobile'],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ])),
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
                child: Text(userDetails['name'],
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'black_label',
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                width: 260,
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    Icon(
                      Icons.call,
                    ),
                    AutoSizeText(
                        new DateFormat("hh:mm a")
                            .format(document['time'].toDate()),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(20),
                            letterSpacing: ScreenUtil.getInstance().setSp(0.1),
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(15)),
                    document['time attended'] == null
                        ? Container()
                        : Icon(Icons.call_end),
                    document['time attended'] == null
                        ? Container()
                        : Expanded(
                            child: AutoSizeText(
                                DateFormat("hh:mm a")
                                    .format(document['time attended'].toDate()),
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    letterSpacing:
                                        ScreenUtil.getInstance().setSp(0.1),
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(20),
                                    fontFamily: 'black_label',
                                    fontWeight: FontWeight.bold))),
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

  _getStatistics() async {
    await Firestore.instance
        .collection('help.current')
        .getDocuments()
        .then((docData) => setState(() {
              numCurrent = docData.documents.length;
              docData.documents.forEach((data) {
                if (data.data['details']['block'] != "")
                  block.add(data.data['details']['block']);
                if (data.data['details']['floor'] != "")
                  floor.add(data.data['details']['floor']);
                if (data.data['details']['floor'] != "" &&
                    data.data['details']['block'] != "")
                  blockFloor.add({
                    'floor': data.data['details']['floor'].toString(),
                    'block': data.data['details']['block'].toString(),
                  });
              });
            }));
    await Firestore.instance
        .collection('help.attended')
        .getDocuments()
        .then((docData) => setState(() {
              numAttended = docData.documents.length;
              docData.documents.forEach((data) {
                if (data.data['details']['block'] != "")
                  block.add(data.data['details']['block']);
                if (data.data['details']['floor'] != "")
                  floor.add(data.data['details']['floor']);
                if (data.data['details']['floor'] != "" &&
                    data.data['details']['block'] != "")
                  blockFloor.add({
                    'floor': data.data['details']['floor'].toString(),
                    'block': data.data['details']['block'].toString(),
                  });
                final DateTime requestTime = data.data['time'].toDate();
                final DateTime helpedTime = data.data['time attended'].toDate();
                final differenceInTime =
                    helpedTime.difference(requestTime).inSeconds;
                averageTimeTaken.add(differenceInTime.toString());
                if (data.data['helper']['helper'] != "")
                  responder.add(data.data['helper']['helper'].toString());
                if (data.data['user'] != "")
                  user.add(data.data['userdetails']['name'].toString());
              });
            }));
    print("Block: ${block.toString()}");
    print("Floor: ${floor.toString()}");
    print("Block & Floor: ${blockFloor.toString()}");
    print("average TimeTaken: ${averageTimeTaken.toString()}");
    print("Responder: ${responder.toString()}");
    print("User: ${user.toString()}");
    print("Attended: $numAttended");
    print("Current: $numCurrent");
  }

  Widget _streamCompleted() {
    return StreamBuilder(
        stream: Firestore.instance.collection('help.attended').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]));
        });
  }

  Widget _streamCurrent() {
    return StreamBuilder(
        stream: Firestore.instance.collection('help.current').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData == false) {
            return SplashScreen();
          } else if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
        });
  }
}
