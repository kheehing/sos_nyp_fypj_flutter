import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:sosnyp/functions/circular_image.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/main.dart';
import 'package:sosnyp/functions/theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();

  popupMenu(context) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        Navigator.of(context).pushNamed('/UpdateProfile');
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Update Profile"),
        ),
      ],
    );
  }
}

class _ProfileState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return _streamBuilder();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1350, allowFontScaling: true);
    _firestoreUpload(image) async {
      final StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(currentUser)
          .putFile(File(image.path));
      final StorageTaskSnapshot taskSnapshot = (await uploadTask.onComplete);
      print(taskSnapshot);
    }

    Future downloadFile() async {
      final StorageReference ref =
          FirebaseStorage.instance.ref().child(currentUser);
      final imageUrl = await ref.getDownloadURL();
      setState(() {
        currentUserImageUrl = imageUrl;
      });
    }

    Future _imageCamera() async {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);
      await _firestoreUpload(image);
      await downloadFile();
    }

    Future _imageGallery() async {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      await _firestoreUpload(image);
      await downloadFile();
    }

    void _profileImageSelection(BuildContext context) {
      showRoundedModalBottomSheet(
          radius: ScreenUtil.getInstance().setHeight(50),
          context: context,
          builder: (builder) {
            return Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: const Radius.circular(10)),
              ),
              child: Container(
                  height: ScreenUtil.getInstance().setHeight(120),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              _imageCamera();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: tCelestialBlue,
                              ),
                              height: ScreenUtil.getInstance().setHeight(90),
                              child: Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              _imageGallery();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: tCelestialBlue,
                              ),
                              height: ScreenUtil.getInstance().setHeight(90),
                              child: Icon(
                                Icons.photo_library,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  )),
            );
          });
    }

    if (data.data == null || data['name'] == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
          Stack(children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().setWidth(420),
              width: ScreenUtil.getInstance().setWidth(420),
              child: currentUserImageUrl == null
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(
                        Icons.account_circle,
                        size: ScreenUtil.getInstance().setHeight(500),
                      ))
                  : CircularImage(NetworkImage(currentUserImageUrl)),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(300),
                    left: ScreenUtil.getInstance().setWidth(300)),
                height: ScreenUtil.getInstance().setHeight(100),
                width: ScreenUtil.getInstance().setHeight(100),
                decoration: BoxDecoration(
                  color: tCelestialBlue,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                    onTap: () {
                      _profileImageSelection(context);
                    },
                    child: Icon(Icons.add,
                        size: ScreenUtil.getInstance().setHeight(60)))),
          ]),
          SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                height: ScreenUtil.getInstance().setHeight(100),
                width: ScreenUtil.getInstance().setWidth(600),
                child: AutoSizeText('Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setHeight(270),
                    )))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                height: ScreenUtil.getInstance().setHeight(40),
                width: ScreenUtil.getInstance().setWidth(500),
                child: AutoSizeText(
                    currentUserType == UserType.user ? 'Admin' : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setHeight(270),
                    )))
          ]),
          SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      ScreenUtil.getInstance().setHeight(40))),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? 'Course' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? '-' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? 'School' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? '-' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? 'Mobile' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? '-' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? 'Gender' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      currentUserType == UserType.user ? '-' : '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
              ])),
        ],
      );
    } else if (currentUserType == UserType.user) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
          Stack(children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().setWidth(420),
              width: ScreenUtil.getInstance().setWidth(420),
              child: currentUserImageUrl == null
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(
                        Icons.account_circle,
                        size: ScreenUtil.getInstance().setHeight(500),
                      ))
                  : CircularImage(NetworkImage(currentUserImageUrl)),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(300),
                    left: ScreenUtil.getInstance().setWidth(300)),
                height: ScreenUtil.getInstance().setHeight(100),
                width: ScreenUtil.getInstance().setHeight(100),
                decoration: BoxDecoration(
                  color: tCelestialBlue,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                    onTap: () {
                      _profileImageSelection(context);
                    },
                    child: Icon(Icons.add,
                        size: ScreenUtil.getInstance().setHeight(60)))),
          ]),
          SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                height: ScreenUtil.getInstance().setHeight(100),
                width: ScreenUtil.getInstance().setWidth(600),
                child: AutoSizeText(data['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setHeight(270),
                    )))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                height: ScreenUtil.getInstance().setHeight(40),
                width: ScreenUtil.getInstance().setWidth(500),
                child: AutoSizeText(data['admin'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setHeight(270),
                    )))
          ]),
          SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      ScreenUtil.getInstance().setHeight(40))),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      'Course',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      data['course'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      'School',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      data['school'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      'Mobile',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      data['mobile'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AutoSizeText(
                      'Gender',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    Expanded(
                        child: AutoSizeText(
                      data['gender'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setHeight(40)),
                    )),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(50))
                  ],
                ),
              ])),
        ],
      );
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
            Stack(children: <Widget>[
              Container(
                height: ScreenUtil.getInstance().setWidth(420),
                width: ScreenUtil.getInstance().setWidth(420),
                child: currentUserImageUrl == null
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Icon(
                          Icons.account_circle,
                          size: ScreenUtil.getInstance().setHeight(500),
                        ))
                    : CircularImage(NetworkImage(currentUserImageUrl)),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(300),
                      left: ScreenUtil.getInstance().setWidth(300)),
                  height: ScreenUtil.getInstance().setHeight(100),
                  width: ScreenUtil.getInstance().setHeight(100),
                  decoration: BoxDecoration(
                    color: tCelestialBlue,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        _profileImageSelection(context);
                      },
                      child: Icon(Icons.add,
                          size: ScreenUtil.getInstance().setHeight(60)))),
            ]),
            SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  height: ScreenUtil.getInstance().setHeight(100),
                  width: ScreenUtil.getInstance().setWidth(600),
                  child: AutoSizeText(data['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setHeight(270),
                      )))
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
          if (!snapshot.hasData) return SplashScreen();
          return _buildListItem(context, snapshot.data);
        });
  }
}
