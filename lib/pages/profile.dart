import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key key, this.title}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _adminController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _schoolController = new TextEditingController();
  TextEditingController _courseController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();

  _updateProfile() {
    final _name = _nameController.text;
    final _admin = _adminController.text;
    final _gender = _genderController.text;
    final _school = _schoolController.text;
    final _course = _courseController.text;
    final _mobile = _mobileController.text;
    debugPrint('_updateProfile test: \n' +
        "\n name:" +
        _name +
        "\n admin:" +
        _admin +
        "\n gender:" +
        _gender +
        "\n school:" +
        _school +
        "\n course:" +
        _course +
        "\n mobile:" +
        _mobile);
  }

  editProfile() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
                // height: 500,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TextField(
                                controller: _nameController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500))),
                      ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('Admin Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TextField(
                                controller: _adminController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500))),
                      ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('Gender',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TextField(
                                controller: _genderController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500))),
                      ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('School',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TextField(
                                controller: _schoolController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500))),
                      ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('Course',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TextField(
                                controller: _courseController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500))),
                      ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('Mobile Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TextField(
                                controller: _mobileController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'black_label',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500))),
                      ])),
                  SizedBox(height: 10),
                  ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Text('Update',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: _updateProfile,
                      )),
                  ButtonTheme(
                      child: FlatButton(
                    color: Colors.transparent,
                    child: Text('close',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () => Navigator.pop(context),
                  )),
                ]))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: ,
    //   builder: (BuildContext context, snapshot){
    //     //scaffold here
    //   }
    // );

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Profile'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: Center(
            child: Column(children: <Widget>[
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
                padding: EdgeInsets.fromLTRB(0, 82, 0, 130),
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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: EdgeInsets.all(10),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: Text('Gender',
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
                            margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
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
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
              child: RaisedButton(
            color: Colors.blueAccent,
            child: Text('Update Profile',
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () {
              editProfile();
            },
          ))
        ])));
  }
}
