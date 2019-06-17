import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
import 'dart:async';

class DashBoardPage extends StatefulWidget {
  final String title;
  const DashBoardPage({Key key, this.title}) : super(key: key);

  @override
  _DashBoardPageState createState() => new _DashBoardPageState();
}

Future<String> inputData() async {
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String uid = user.uid.toString();
  return uid;
}

class _DashBoardPageState extends State<DashBoardPage> {
  List current;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: new MyDrawer(),
        appBar: AppBar(
          title: Text('DashBoard'),
          leading: myLeading,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Current')),
              Tab(child: Text('Attended')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
                stream:
                    Firestore.instance.collection('help.current').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return ListView.builder(
                    // itemExtent: 80,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  );
                }),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    TextEditingController _controllerName = new TextEditingController();
    Firestore.instance
        .collection('profile')
        .document(document['user'].toString())
        .get()
        .then((data) {
      setState(() async {
        _controllerName.text = await data['name'];
      });
    });
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controllerName,
              enabled: false,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Expanded(
            child: Text(
              document['latitude'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: Text(
              document['longitude'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          )
        ],
      ),
      onTap: () {
        print('Should increase votes here.');
      },
    );
  }
}
