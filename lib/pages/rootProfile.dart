import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sosnyp/main.dart';

class RootProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootProfileState();
}

class _RootProfileState extends State<RootProfilePage> {
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Profile'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: StreamBuilder(
            stream: Firestore.instance.collection('profile').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return loadingScreen();
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }));
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  // final _gender = document['name'].toString().toLowerCase();

  return ListTile(
      title: Stack(children: <Widget>[
    Align(
        alignment: Alignment(1, -0.2),
        child: Icon(
          Icons.assignment_return,
          size: 600,
          color: Colors.blue.shade200,
        )),
    Column(children: <Widget>[
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(40, 80, 0, 0),
        child: Icon(
          Icons.account_circle,
          size: 100,
          color: Colors.grey,
        ),
      ),
      Stack(
        children: <Widget>[
          Container(),
          Container(),
        ],
      ),
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(document['name'],
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'black_label',
                fontWeight: FontWeight.w900,
              ))),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          document['admin'],
          maxLines: 1,
          softWrap: false,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'black_label',
              fontWeight: FontWeight.w900),
        ),
      ),
      Stack(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(vertical: 80),
            margin: new EdgeInsets.fromLTRB(30, 15, 30, 50),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                  )
                ]),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: new EdgeInsets.fromLTRB(30, 15, 30, 50),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  'Mobile',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'black_label',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                            Expanded(
                                child: Text(document['mobile'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'black_label',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500))),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        padding: EdgeInsets.all(10),
                        child: Row(children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Text('School',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'black_label',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))),
                          Expanded(
                              child: Text(document['school'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'black_label',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                        ])),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  'Course',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'black_label',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                            Expanded(
                                child: Text(document['course'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'black_label',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500))),
                          ],
                        )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text('Update Profile',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/UpdateProfile');
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    ])
  ]));
}
