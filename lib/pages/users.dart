import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Future _showAlert(context) {
  return showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(ScreenUtil.getInstance().setSp(25)),
          color: Colors.white,
        ),
        width: ScreenUtil.getInstance().setWidth(600),
        height: ScreenUtil.getInstance().setHeight(750),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(10)),
        child: Scaffold(
            body: Container(
          width: ScreenUtil.getInstance().setWidth(580),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('button 1'),
                  onPressed: () {
                    print('test1');
                  },
                ),
              ]),
        )),
      ),
    ),
  );
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var _searchview = TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<String> _listName;
  List<String> _filterListName;

  _UserPageState() {
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
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        children: <Widget>[
          _createSearchView(),
          _firstSearch ? _createListView() : _performSearch()
        ],
      ),
    );
  }

  getDBProfile() {
    _listName = new List<String>();
    Firestore.instance.collection('profile').snapshots().listen((snapshot) =>
        snapshot.documents.forEach((documentSnapshot) => setState(() {
              _listName.add(capitalize(documentSnapshot.data['name']));
            })));
    _listName.sort();
  }

  @override
  void initState() {
    super.initState();
    getDBProfile();
  }

  Widget _createFilteredListView() {
    return Flexible(
      child: ListView.builder(
          itemCount: _filterListName.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => _showAlert(context),
              title: Text("${_filterListName[index]}"),
            );
          }),
    );
  }

  Widget _createListView() {
    return Flexible(
      child: ListView.builder(
          itemCount: _listName.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => _showAlert(context),
              title: Text("${_listName[index]}"),
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
    _filterListName = List<String>();
    for (int i = 0; i < _listName.length; i++) {
      var item = _listName[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterListName.add(item);
      }
    }
    return _createFilteredListView();
  }
}
