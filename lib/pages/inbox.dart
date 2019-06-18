import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => new _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  Stream<QuerySnapshot> helpCurrent;

  @override
  void initState() {
    super.initState();
    helpCurrent = Firestore.instance.collection('help.current').snapshots();
  }

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
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
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
    TextEditingController _controllerNameDialog = new TextEditingController();
    TextEditingController _controllerGenderDialog = new TextEditingController();
    TextEditingController _controllerAdminDialog = new TextEditingController();

    Firestore.instance
        .collection('profile')
        .document(document['user'].toString())
        .get()
        .then((data) {
      setState(() async {
        String _name = await data['name'];
        String _gender = await data['gender'];
        String _admin = await data['admin'];
        _controllerName.text = _name;
        _controllerNameDialog.text = 'Name:  ' + _name;
        _controllerGenderDialog.text = 'Sex:  ' + _gender;
        _controllerAdminDialog.text = 'Admin:  ' + _admin;
      });
    });

    void _showDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                title: Column(
                  children: <Widget>[
                    TextField(
                        controller: _controllerNameDialog,
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.w900)),
                    TextField(
                        controller: _controllerAdminDialog,
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.w900)),
                    TextField(
                        controller: _controllerGenderDialog,
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.w900)),
                    Text('Location',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'black_label',
                            fontWeight: FontWeight.w900)),
                    // Row(
                    //   children: <Widget>[
                    //     TextField(
                    //         controller: _controllerGenderDialog,
                    //         enabled: false,
                    //         decoration:
                    //             InputDecoration(border: InputBorder.none),
                    //         style: TextStyle(
                    //             fontSize: 15,
                    //             fontFamily: 'black_label',
                    //             fontWeight: FontWeight.w900)),
                    //   ],
                    // )
                  ],
                ));
          });
    }

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                  controller: _controllerName,
                  enabled: false,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'black_label',
                      fontWeight: FontWeight.w900))),
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
    );
  }
}
