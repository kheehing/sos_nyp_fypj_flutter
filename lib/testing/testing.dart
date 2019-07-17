import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  var _searchview = TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<String> _userList;
  List<String> _filterList;
  _getData() async {
    print('1');
    var x = Firestore.instance.collection('profile').snapshots();
    x.map((doc) => doc.documents.map((doc) {
          print('2');
          print(doc['name']);
          setState(() {
            print('3');
            _userList.add(doc['name'].toString());
          });
        }));
  }

  @override
  void initState() {
    super.initState();
    _userList = new List<String>();
    _getData();
    print('userList: ' + _userList.toString());
    // _userList = [
    //   "Orion",
    //   "Boomerang",
    //   "Cat's Eye",
    //   "Pelican",
    //   "Ghost Head",
    //   "Witch Head",
    //   "Snake",
    //   "Ant",
    //   "Bernad 68",
    //   "Flame",
    //   "Eagle",
    //   "Horse Head",
    //   "Elephant's Trunk",
    //   "Butterfly"
    // ];
    _userList.sort();
  }

  _TestState() {
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
//Build our Home widget
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

//Create a SearchView
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

//Create a ListView widget
  Widget _createListView() {
    return Flexible(
        child: ListView.builder(
            itemCount: _userList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () => print('object'),
                title: Text("${_userList[index]}"),
              );
            }));
  }

//Perform actual search
  Widget _performSearch() {
    _filterList = List<String>();
    for (int i = 0; i < _userList.length; i++) {
      var item = _userList[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

//Create the Filtered ListView
  Widget _createFilteredListView() {
    return Flexible(
      child: ListView.builder(
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              elevation: 5.0,
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Text("${_filterList[index]}"),
              ),
            );
          }),
    );
  }
}
