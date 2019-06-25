import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sosnyp/main.dart';
import 'package:sosnyp/pages/profileDefault.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  File _image;
  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Profile'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: _streamBuilder());
  }

  Future<Null> downloadFile() async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(currentUser);
    final imageUrl = await ref.getDownloadURL();
    Image image = Image.network(imageUrl.toString());
    setState(() {
      _image = image as File;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //FireStore
    String fileName = currentUser.toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask =
        firebaseStorageRef.putFile(File(image.path));
    final StorageTaskSnapshot taskSnapshot = (await uploadTask.onComplete);
    final String url = (await taskSnapshot.ref.getDownloadURL());
    print('URL Is $url');
    setState(() {
      _image = image;
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    if (data.data == null || data['name'] == null) {
      return ProfileEmptyPage();
    } else {
      final _gender = data['gender'].toString().toLowerCase();
      _gendercolor(String value) {
        var color = Colors.grey.shade300;
        if (value.toLowerCase() == 'male') {
          color = Colors.blue.shade200;
        } else if (value.toLowerCase() == 'female') {
          color = Colors.pink.shade200;
        }
        return color;
      }

      return Stack(children: <Widget>[
        Align(
            alignment: Alignment(1, -0.2),
            child: Icon(
              Icons.face,
              size: 600,
              color: _gendercolor(_gender),
            )),
        Column(children: <Widget>[
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(100)),
              // alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(
                  0, 50, MediaQuery.of(context).size.width / 1.7, 0),
              child: GestureDetector(
                  onTap: () {
                    getImage();
                    print('object');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(100)),
                    child: _image == null
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Stack(children: <Widget>[
                              Icon(
                                // Icons.add_a_photo,
                                Icons.account_circle,
                                size: 300,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(200, 200, 0, 0),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey.shade800,
                                  size: 100,
                                ),
                              ),
                            ]),
                          )
                        : Container(
                            margin: EdgeInsets.all(2),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ))),
                  ))),
          Stack(
            children: <Widget>[
              Container(),
              Container(),
            ],
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(data['name'],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17.5,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.bold,
                  ))),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              data['admin'],
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
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
                            Navigator.pushNamed(context, '/UpdateProfile');
                          },
                        ))
                  ],
                ),
              ),
            ],
          ),
        ])
      ]);
    }
  }

  _streamBuilder() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('profile')
            .document(currentUser)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return loadingScreen();
          return _buildListItem(context, snapshot.data);
        });
  }
}
