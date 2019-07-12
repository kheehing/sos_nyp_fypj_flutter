import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sosnyp/main.dart';

PermissionStatus _status;
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

helpButtonOnClick(context) async {
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
      'status': 'request',
      'latitude': currentLocation.latitude.toString(),
      'longitude': currentLocation.longitude.toString(),
      'time': DateTime.now(),
    }).catchError((onError) {});
  }
}

shadow(double marginLeft) {
  return Container(
    margin:
        EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(marginLeft)),
    height: ScreenUtil.getInstance().setHeight(100),
    width: ScreenUtil.getInstance().setWidth(290),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: Offset(10, 10),
            blurRadius: 15.0),
      ],
    ),
  );
}

void _updateStatus(PermissionStatus status) {
  if (status != _status) {
    _status = status;
  }
}

enum Progress {
  normal,
  request,
  details,
  waiting,
  otw,
}
