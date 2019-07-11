import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sosnyp/functions/theme.dart';
import 'package:sosnyp/main.dart';
import 'package:url_launcher/url_launcher.dart';

// final Tween<BorderRadius> _bevelRadius = new BorderRadiusTween(
//     begin: const BorderRadius.only(
//       topRight: Radius.circular(28.0),
//       bottomRight: Radius.circular(28.0),
//     ),
//     end: const BorderRadius.only(
//       topRight: Radius.circular(28.0),
//       bottomRight: Radius.circular(28.0),
//     ));
PermissionStatus _status;

button(context, String buttonTitle) {
  Key test = GlobalKey(debugLabel: 'AnimatedContainer Key');
  return GestureDetector(
      child: AnimatedContainer(
    key: test,
    duration: Duration(milliseconds: 300),
    height: ScreenUtil.getInstance().setHeight(100),
    width: ScreenUtil.getInstance().setWidth(700),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: tCelestialBlue,
      boxShadow: [
        BoxShadow(color: Colors.black26.withOpacity(.3), blurRadius: 1.0),
        BoxShadow(
            color: Colors.black26.withOpacity(.3),
            offset: Offset(5.0, 8.0),
            blurRadius: 5.0),
        BoxShadow(
            color: Colors.black26.withOpacity(.3),
            offset: Offset(5.0, 5.0),
            blurRadius: 5.0)
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          helpButton(context);
        },
        child: Center(
          child: Text(buttonTitle == null ? 'Help' : buttonTitle),
        ),
      ),
    ),
  ));
}

detailsButton(context) {
  return InkWell(
    child: Container(
      height: ScreenUtil.getInstance().setHeight(100),
      width: ScreenUtil.getInstance().setWidth(700),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: tCelestialBlue,
        boxShadow: [
          BoxShadow(color: Colors.black26.withOpacity(.3), blurRadius: 1.0),
          BoxShadow(
              color: Colors.black26.withOpacity(.3),
              offset: Offset(5.0, 8.0),
              blurRadius: 5.0),
          BoxShadow(
              color: Colors.black26.withOpacity(.3),
              offset: Offset(5.0, 5.0),
              blurRadius: 5.0)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            detailsButtonOnClick();
          },
          child: Center(
            child: Text("Provide More Details"),
          ),
        ),
      ),
    ),
  );
}

detailsButtonOnClick() async {
  var data = await Firestore.instance
      .collection('help.current')
      .document(currentUser)
      .get();
  if (data.data == null) {
  } else if (data.data['statusPrevious'] == null) {
  } else {
    Firestore.instance
        .collection('help.current')
        .document(currentUser)
        .updateData({
      'status': 'details',
      'time': DateTime.now(),
    }).catchError((onError) {
      print(onError);
    });
  }
}

detailsButtonUpdate(context) {
  return GestureDetector(
      onTap: () {
        detailsButtonOnClick();
      },
      child: Container(
          height: ScreenUtil.getInstance().setHeight(100),
          width: ScreenUtil.getInstance().setWidth(700),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26.withOpacity(.3), blurRadius: 1.0),
                BoxShadow(
                    color: Colors.black26.withOpacity(.3),
                    offset: Offset(3.0, 5.0),
                    blurRadius: 3.0),
                BoxShadow(
                    color: Colors.black26.withOpacity(.3),
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0)
              ],
              color: tCelestialBlue,
              borderRadius: BorderRadius.circular(
                  ScreenUtil.getInstance().setHeight(10))),
          margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(25)),
          child: Center(
            child: Text(
              'Update Details',
            ),
          )));
}

detailsForm() {
  return Text(
      'Block: (DropDown [allBlocks + notSure])\nFloor: (DropDown [allFloors if(Block.isSelected) + notSure])\nRemarks: (MultiLine Textbox())\nButton(Update)');
}

helpButton(context) async {
  void _onStatusRequest(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
    if (status != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    }
  }

  PermissionHandler().requestPermissions(
      [PermissionGroup.locationWhenInUse]).then(_onStatusRequest);
  var currentLocation = LocationData.fromMap(Map<String, double>());
  var location = new Location();
  try {
    currentLocation = await location.getLocation();
  } catch (e) {
    currentLocation = null;
  }
  var data = await Firestore.instance
      .collection('help.current')
      .document(currentUser)
      .get();
  var profileData = await Firestore.instance
      .collection('profile')
      .document(currentUser)
      .get();
  if (!profileData.exists) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Text('Update your profile first'),
    ));
  } else if (data.data == null) {
    Firestore.instance
        .collection('help.current')
        .document(currentUser)
        .setData({
      'latitude': currentLocation.latitude.toString(),
      'longitude': currentLocation.longitude.toString(),
      'status': 'request',
      'type': 'help',
      'statusPrevious': 'request',
      'helper': '',
      'helper otw': '',
      'user.name': profileData['name'],
      'user.admin': profileData['admin'],
      'user.course': profileData['course'],
      'user.school': profileData['school'],
      'user.gender': profileData['gender'],
      'user.mobile': profileData['mobile'],
      'user': currentUser,
      'time': DateTime.now(),
    }).catchError((onError) {});
  } else {
    Firestore.instance
        .collection('help.current')
        .document(currentUser)
        .updateData({
      'latitude': currentLocation.latitude.toString(),
      'longitude': currentLocation.longitude.toString(),
      'time': DateTime.now(),
    }).catchError((onError) {});
  }
}

homePageContentDetails(context) {
  return Container(
      height: ScreenUtil.getInstance().setHeight(700),
      child: Column(children: <Widget>[
        Container(
            child: Center(
                // Make a Form
                child: Container())),
        // Temp just for Presemtation
        GestureDetector(
            onTap: () {
              zfakeDetailSubmitButtonOnclick();
            },
            child: Container(
                height: ScreenUtil.getInstance().setHeight(100),
                width: ScreenUtil.getInstance().setWidth(700),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(.3),
                          blurRadius: 1.0),
                      BoxShadow(
                          color: Colors.black26.withOpacity(.3),
                          offset: Offset(5.0, 8.0),
                          blurRadius: 5.0),
                      BoxShadow(
                          color: Colors.black26.withOpacity(.3),
                          offset: Offset(5.0, 5.0),
                          blurRadius: 5.0)
                    ],
                    color: tCelestialBlue,
                    borderRadius: BorderRadius.circular(
                        ScreenUtil.getInstance().setHeight(10))),
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(25)),
                child: Center(
                  child: Text(
                    'Submit',
                  ),
                ))),
      ]));
}

homePageContentNormal() {
  return Container(
    // color: Colors.pink,
    height: ScreenUtil.getInstance().setHeight(700),
    child: Column(children: <Widget>[
      Spacer(),
      Container(
          child: AutoSizeText(
        'If you need help, tap on the \'Help\' button. For futher assistance you may call the ',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
      )),
      Container(
        child: GestureDetector(
            onTap: () => launch("tel://+65123456789"),
            child: AutoSizeText("emergency hotline",
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xFF5d74e3),
                    decoration: TextDecoration.underline,
                    fontSize: ScreenUtil.getInstance().setSp(50)))),
      ),
    ]),
  );
}

homePageContentRequest(context) {
  return Container(
      height: ScreenUtil.getInstance().setHeight(700),
      child: Column(children: <Widget>[
        Spacer(),
        Container(
          width: ScreenUtil.getInstance().setWidth(500),
          child: AutoSizeText(
            'Your Request is currently being Process.\nYou may want to add more details of your current location\nthis will help our staff to find you faster',
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(),
        detailsButton(context),
      ]));
}

statusBarNormal() {
  return Container(
    height: ScreenUtil.getInstance().setHeight(100),
    color: tCelestialBlue2,
    child: Center(
        child: AutoSizeText('Normal',
            style: TextStyle(
              color: tWhite,
              fontSize: ScreenUtil.getInstance().setSp(100),
            ))),
  );
}

statusBarOTW() {
  return Container(
      height: ScreenUtil.getInstance().setHeight(100),
      child: Stack(fit: StackFit.passthrough, children: <Widget>[
        Container(
            width: ScreenUtil.getInstance().setWidth(750),
            color: tCelestialBlue2),
        Container(
            width: ScreenUtil.getInstance().setWidth(750),
            height: ScreenUtil.getInstance().setHeight(100),
            child: Container(
                child: Center(
                    child: AutoSizeText(
              'Help Is On The Way',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: tWhite, fontSize: ScreenUtil.getInstance().setSp(70)),
            ))),
            decoration: BoxDecoration(
              color: tRoyalBlue,
            )),
      ]));
}

zfakeDetailSubmitButtonOnclick() async {
  var data = await Firestore.instance
      .collection('help.current')
      .document(currentUser)
      .get();
  if (data.data == null) {
  } else if (data.data['statusPrevious'] == "OTW" &&
      data.data['status'] == "details") {
    Firestore.instance
        .collection('help.current')
        .document(currentUser)
        .updateData({
      'status': 'OTW',
      'time': DateTime.now(),
    }).catchError((onError) {});
  } else {
    Firestore.instance
        .collection('help.current')
        .document(currentUser)
        .updateData({
      'status': 'waiting',
      'statusPrevious': 'waiting',
      'time': DateTime.now(),
    }).catchError((onError) {});
  }
}

zfakeSubmitButton(context) {
  return GestureDetector(
      onTap: () {
        zfakeDetailSubmitButtonOnclick();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Updated'),
        ));
      },
      child: Container(
          height: ScreenUtil.getInstance().setHeight(100),
          width: ScreenUtil.getInstance().setWidth(700),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26.withOpacity(.3), blurRadius: 1.0),
                BoxShadow(
                    color: Colors.black26.withOpacity(.3),
                    offset: Offset(5.0, 8.0),
                    blurRadius: 5.0),
                BoxShadow(
                    color: Colors.black26.withOpacity(.3),
                    offset: Offset(5.0, 5.0),
                    blurRadius: 5.0)
              ],
              color: tCelestialBlue,
              borderRadius: BorderRadius.circular(
                  ScreenUtil.getInstance().setHeight(10))),
          margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(25)),
          child: Center(
            child: Text('Submit'),
          )));
}

void _updateStatus(PermissionStatus status) {
  if (status != _status) {
    _status = status;
  }
}
