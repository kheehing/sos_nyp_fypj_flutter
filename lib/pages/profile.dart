import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key key, this.title}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Profile'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: Center(
            child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(1, -0.2),
              child: Icon(
                Icons.face,
                size: 500,
                color: Colors.grey,
              ),
            ),
            Column(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(50, 100, 0, 0),
                child: Text('Image left side'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(50, 30, 0, 0),
                child: Text(
                  'Name',
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Text(
                  'Admin',
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                    margin: new EdgeInsets.fromLTRB(30, 30, 30, 50),
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
                    margin: new EdgeInsets.fromLTRB(30, 30, 30, 50),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                padding: EdgeInsets.all(10),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: Text('School',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'black_label',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Expanded(
                                      child: Text('data',
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
                                    Expanded(
                                        child: Text(
                                      'Course',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'black_label',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    Expanded(
                                        child: Text('data',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      'Mobile Number',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'black_label',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    Expanded(
                                        child: Text('data',
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
                            margin: EdgeInsets.only(top: 50),
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              child: Text('Update Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/UpdateProfile');
                              },
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ])
          ],
        )));
  }
}
