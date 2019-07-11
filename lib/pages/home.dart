import 'package:auto_size_text/auto_size_text.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/functions/theme.dart';
import 'package:sosnyp/main.dart';
import 'package:url_launcher/url_launcher.dart';

backgroundColor(pBar, currentProgress) {
  Color thisColor;
  switch (pBar) {
    case Progress.normal:
      break;
    case Progress.request:
      if (pBar == currentProgress)
        return thisColor = Colors.white;
      else if (currentProgress == Progress.normal)
        return thisColor = tCelestialBlue;
      else
        return thisColor = Color(0xff757575);
      break;
    case Progress.details:
      if (pBar == currentProgress)
        return thisColor = Colors.white;
      else if (currentProgress == Progress.request ||
          currentProgress == Progress.normal)
        return thisColor = tCelestialBlue;
      else
        return thisColor = Color(0xff757575);
      break;
    case Progress.waiting:
      if (pBar == currentProgress)
        return thisColor = Colors.white;
      else if (currentProgress == Progress.otw)
        return thisColor = Color(0xff757575);
      else
        return thisColor = tCelestialBlue;
      break;
    case Progress.otw:
      if (pBar == currentProgress)
        return thisColor = Colors.white;
      else
        return thisColor = tCelestialBlue;
      break;
  }
  return thisColor;
}

fontColor(pBar, currentProgress) {
  Color thisColor;
  switch (pBar) {
    case Progress.normal:
      break;
    case Progress.request:
      if (pBar == currentProgress)
        return thisColor = Colors.black;
      else if (currentProgress == Progress.normal)
        return thisColor = Colors.white;
      else
        return thisColor = Color(0xff424242);
      break;
    case Progress.details:
      if (pBar == currentProgress)
        return thisColor = Colors.black;
      else if (currentProgress == Progress.request ||
          currentProgress == Progress.normal)
        return thisColor = Colors.white;
      else
        return thisColor = Color(0xff424242);
      break;
    case Progress.waiting:
      if (pBar == currentProgress)
        return thisColor = Colors.black;
      else if (currentProgress == Progress.request ||
          currentProgress == Progress.otw)
        return thisColor = Color(0xff424242);
      else
        return thisColor = Colors.white;
      break;
    case Progress.otw:
      if (pBar == currentProgress)
        return thisColor = Colors.black;
      else
        return thisColor = Colors.white;
      break;
  }
  return thisColor;
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

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();

  popupMenu() {
    return InkWell(
      onTap: () => print('refreshs'),
      child: Icon(Icons.cached),
    );
  }
}

enum Progress {
  normal,
  request,
  details,
  waiting,
  otw,
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Progress currentProgress;
  double progressBarNum;
  double distance = 0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1350, allowFontScaling: true);
    title = "SOS NYP";
    return Column(
      children: <Widget>[
        Container(
          child: Column(children: <Widget>[
            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
            Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.black,
            ),
            SizedBox(height: ScreenUtil.getInstance().setHeight(5)),
            progressBar(),
            SizedBox(height: ScreenUtil.getInstance().setHeight(15)),
            Container(
                height: ScreenUtil.getInstance().setHeight(800),
                child: Column(children: <Widget>[
                  Spacer(),
                  content(),
                  Spacer(),
                ])),
          ]),
        ),
      ],
    );
  }

  content() {
    // workingrequeset
    switch (currentProgress) {
      case Progress.normal:
        return Container(
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

        break;
      case Progress.request:
        return Text('request');
        break;
      case Progress.details:
        return Text('details');
        break;
      case Progress.waiting:
        return Text('waiting');
        break;
      case Progress.otw:
        return Text('otw');
        break;
      default:
        return Center(child: SplashScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    setCurrentProgress();
  }

  progressBar() {
    return Container(
        height: ScreenUtil.getInstance().setHeight(120),
        child: Stack(fit: StackFit.passthrough, children: <Widget>[
          OverflowBox(
              maxWidth: ScreenUtil.getInstance().setWidth(10000),
              child: Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(990)),
                  child: Container(
                      margin: EdgeInsets.only(
                          right: ScreenUtil.getInstance().setWidth(distance)),
                      child: Center(
                          child: Stack(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil.getInstance().setHeight(25)),
                            color: Colors.white,
                          ),
                          width: ScreenUtil.getInstance().setWidth(750),
                          height: ScreenUtil.getInstance().setHeight(100),
                        ),
                        currentProgress == Progress.otw
                            ? shadow(988)
                            : SizedBox(),
                        progressBarContent('HI.OTW', 988, Progress.otw),
                        currentProgress == Progress.waiting
                            ? shadow(741)
                            : SizedBox(),
                        progressBarContent('waiting', 741, Progress.waiting),
                        currentProgress == Progress.details
                            ? shadow(494)
                            : SizedBox(),
                        progressBarContent('Details', 494, Progress.details),
                        currentProgress == Progress.request
                            ? shadow(247)
                            : SizedBox(),
                        progressBarContent('Request', 247, Progress.request),
                        currentProgress == Progress.normal
                            ? shadow(0)
                            : SizedBox(),
                        progressBarHeader('Normal'),
                      ]))))),
        ]));
  }

  progressBarContent(String text, double marginLeft, Progress pBar) {
    return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(marginLeft)),
        height: ScreenUtil.getInstance().setHeight(100),
        width: ScreenUtil.getInstance().setWidth(300),
        child: Chevron(
          triangleHeight: ScreenUtil.getInstance().setHeight(50),
          child: Container(
            color: backgroundColor(pBar, currentProgress),
            padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(25)),
            child: Center(
                child: AutoSizeText(text,
                    maxLines: 1,
                    style: TextStyle(
                      color: fontColor(pBar, currentProgress),
                      fontSize: ScreenUtil.getInstance().setSp(90),
                    ))),
          ),
        ));
  }

  progressBarHeader(String text) {
    return Container(
        height: ScreenUtil.getInstance().setHeight(100),
        width: ScreenUtil.getInstance().setWidth(300),
        child: Point(
          triangleHeight: ScreenUtil.getInstance().setWidth(50),
          edge: Edge.RIGHT,
          child: Container(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(25)),
            decoration: BoxDecoration(
                color: currentProgress == Progress.normal
                    ? Colors.white
                    : Color(0xff757575),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(ScreenUtil.getInstance().setHeight(25)),
                  bottomLeft:
                      Radius.circular(ScreenUtil.getInstance().setHeight(25)),
                )),
            child: Center(
                child: AutoSizeText(text,
                    maxLines: 1,
                    style: TextStyle(
                      color: currentProgress == Progress.normal
                          ? Colors.black
                          : Color(0xff424242),
                      fontSize: ScreenUtil.getInstance().setSp(90),
                    ))),
          ),
        ));
  }

  setCurrentProgress() {
    Firestore.instance
        .collection('help.current')
        .document(currentUser)
        .get()
        .then((db) {
      final current = db.data['status'].toString();
      switch (current) {
        case "normal":
          setState(() {
            currentProgress = Progress.normal;
            distance = 0;
          });
          break;
        case "request":
          setState(() {
            currentProgress = Progress.request;
            distance = 495;
          });
          break;
        case "details":
          setState(() {
            currentProgress = Progress.details;
            distance = 990;
          });
          break;
        case "waiting":
          setState(() {
            currentProgress = Progress.waiting;
            distance = 1485;
          });
          break;
        case "otw":
          setState(() {
            currentProgress = Progress.otw;
            distance = 1980;
          });
          break;
      }
    });
  }
}
