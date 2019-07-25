import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
enableAccount(String uid) {
  Firestore.instance.collection('profile').document(uid).updateData({
    'enabled': true,
  });
}

suspendAccount(String uid) {
  Firestore.instance.collection('profile').document(uid).updateData({
    'enabled': false,
  });
}

Future _showAlert(BuildContext context, _listProfile) {
  Widget showAlertText(String title, String content, double height) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(100),
      margin: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(height),
        left: ScreenUtil.getInstance().setWidth(10),
        right: ScreenUtil.getInstance().setWidth(10),
      ),
      child: Row(children: <Widget>[
        Container(
            width: ScreenUtil.getInstance().setWidth(220),
            child: Text(
              title,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(50),
                  letterSpacing: ScreenUtil.getInstance().setSp(1)),
            )),
        Expanded(
            child: AutoSizeText(
          content,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(50)),
        )),
      ]),
    );
  }

  return showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenUtil.getInstance().setSp(25),
          ),
          color: Colors.white,
        ),
        width: ScreenUtil.getInstance().setWidth(650),
        height: ScreenUtil.getInstance().setHeight(750),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(25)),
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  ScreenUtil.getInstance().setSp(25),
                ),
                color: Colors.white,
              ),
              width: ScreenUtil.getInstance().setWidth(650),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil.getInstance().setHeight(450),
                      child: Stack(children: <Widget>[
                        showAlertText('Name:', _listProfile['name'], 0),
                        showAlertText('Admin:', _listProfile['admin'], 60),
                        showAlertText('School:', _listProfile['school'], 120),
                        showAlertText('Course:', _listProfile['course'], 180),
                        showAlertText('Mobile:', _listProfile['mobile'], 240),
                        showAlertText(
                            'AcType:', _listProfile['accountType'], 300),
                        showAlertText(
                            'Enable:', _listProfile['enabled'].toString(), 370),
                      ]),
                    ),
                    RaisedButton(
                        child: Text('Suspend Account'),
                        onPressed: () {
                          suspendAccount(_listProfile['uid']);
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                    RaisedButton(
                        child: Text('Enable Account'),
                        onPressed: () {
                          enableAccount(_listProfile['uid']);
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                  ]),
            )),
      ),
    ),
  );
}

class ManageStaffPage extends StatefulWidget {
  @override
  _ManageStaffPageState createState() => _ManageStaffPageState();
}

class _ManageStaffPageState extends State<ManageStaffPage> {
  var _searchview = TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<dynamic> _listProfile;
  List<dynamic> _filterListProfile;

  _ManageStaffPageState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Staff',
            style: TextStyle(fontFamily: 'Black_Label'),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: <Widget>[
              _createSearchView(),
              _firstSearch ? _createListView() : _performSearch()
            ],
          ),
        ));
  }

  getDBProfile() {
    Firestore.instance.collection('profile').snapshots().listen((snapshot) {
      _listProfile = new List<dynamic>();
      snapshot.documents.forEach((documentSnapshot) => setState(() {
            if (documentSnapshot.data['accountType'] == 'staff') {
              _listProfile.add({
                'accountType': documentSnapshot.data['accountType'].toString(),
                'admin': documentSnapshot.data['admin'].toString(),
                'course': documentSnapshot.data['course'].toString(),
                'enabled': documentSnapshot.data['enabled'].toString(),
                'gender': documentSnapshot.data['gender'].toString(),
                'mobile': documentSnapshot.data['mobile'].toString(),
                'name': capitalize(documentSnapshot.data['name'].toString()),
                'school': documentSnapshot.data['school'].toString(),
                'uid': documentSnapshot.documentID.toString(),
              });
            }
          }));
      _listProfile..sort((a, b) => a['name'].compareTo(b['name']));
    });
  }

  @override
  void initState() {
    super.initState();
    _listProfile = new List<dynamic>();
    getDBProfile();
  }

  Widget _createFilteredListView() {
    return Flexible(
      child: ListView.builder(
          itemCount: _filterListProfile.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => _showAlert(context, _filterListProfile[index]),
              title: Text("${_filterListProfile[index]['name']}"),
            );
          }),
    );
  }

  Widget _createListView() {
    return Flexible(
      child: ListView.builder(
          itemCount: _listProfile.length == null ? 10 : _listProfile.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => _showAlert(context, _listProfile[index]),
              title: Text("${_listProfile[index]['name']}"),
            );
          }),
    );
  }

  Widget _createSearchView() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.getInstance().setWidth(20),
        vertical: ScreenUtil.getInstance().setHeight(10),
      ),
      child: TextField(
        controller: _searchview,
        decoration: InputDecoration(
          labelText: "Search User",
          labelStyle: TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _performSearch() {
    _filterListProfile = new List<dynamic>();
    for (int i = 0; i < _listProfile.length; i++) {
      var item = _listProfile[i]['name'];
      var acType = _listProfile[i]['accountType'];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterListProfile.add(_listProfile[i]);
      } else if (acType.toLowerCase().contains(_query.toLowerCase())) {
        _filterListProfile.add(_listProfile[i]);
      }
    }
    return _createFilteredListView();
  }
}
