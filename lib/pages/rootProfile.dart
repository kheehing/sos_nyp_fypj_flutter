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
            initialData: 'Na',
            stream: Firestore.instance
                .collection('profile')
                .document(currentUser)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return loadingScreen();
              if (snapshot.hasData) {
                return ListView.builder(
                  // itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data),
                );
              }
            }));
  }
}

// Widget _buildList (BuildContext context, List<DocumentSnapshot> snapshot){
//   return ListView(
//     padding: const EdgeInsets.all(10),
//     children: snapshot.map((data) => _buildList(context,data)).toList(),
//   )
// }

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  // final _gender = document['gender'].toString().toLowerCase();
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
        margin: EdgeInsets.fromLTRB(30, 50, 0, 10),
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
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Text(data['name'],
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'black_label',
                fontWeight: FontWeight.w900,
              ))),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Text(
          data['admin'],
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
            padding: EdgeInsets.symmetric(vertical: 85),
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
                                child: Text(data['mobile'],
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
                              child: Text(data['school'],
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
                                child: Text(data['course'],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontFamily: 'black_label',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500))),
                          ],
                        )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text('Update Profile',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/UpdateProfile');
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
