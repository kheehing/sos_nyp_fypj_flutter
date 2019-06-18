import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => new _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List current;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      child: Scaffold(
        drawer: new MyDrawer(),
        appBar: AppBar(
          title: Text('DashBoard'),
          leading: myLeading,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Current')),
              Tab(child: Text('Attended')),
              Tab(child: Text('Statistics')),
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
            Text('Statistics'),
          ],
        ),
      ),
      length: 3,
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (!document.exists) {
      return loadingScreen();
    }
    TextEditingController _controllerName = new TextEditingController();
    TextEditingController _controllerNameDialog = new TextEditingController();

    Firestore.instance
        .collection('profile')
        .document(document['user'].toString())
        .get()
        .then((data) {
      setState(() async {
        String _name = await data['name'];
        _controllerName.text = _name;
        _controllerNameDialog.text = _name + ' Details';
      });
    });

    void _showDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: TextField(
                controller: _controllerNameDialog,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.w900),
              ),
            );
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
        print('Should increase votes here.');
      },
    );
  }
}
