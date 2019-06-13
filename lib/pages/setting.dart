import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

var geolocator = Geolocator();
var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
    (Position position) {
        print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });
testing() async{
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position.latitude.toString();
}
class _SettingPageState extends State<SettingPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: Text('Profile'),
          leading: myLeading,
        ),
        body: Center(child: Text(testing().toString())));
  }
}
