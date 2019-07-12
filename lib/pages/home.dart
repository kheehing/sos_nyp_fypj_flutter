import 'package:auto_size_text/auto_size_text.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/homepage-function.dart';
import 'package:sosnyp/functions/hompage-campus-repo.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/functions/theme.dart';
import 'package:sosnyp/main.dart';
import 'package:url_launcher/url_launcher.dart';

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
  loading,
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Progress currentProgress = Progress.loading;
  List<String> _block = ["Choose a Block"];
  List<String> _floor = ["Choose .."];
  String _selectedBlock = "Choose a Block";
  String _selectedFloor = "Choose ..";

  Repository repo = Repository();
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
            currentProgress == Progress.loading
                ? Container()
                : Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.black,
                  ),
            SizedBox(height: ScreenUtil.getInstance().setHeight(5)),
            currentProgress == Progress.loading ? Container() : progressBar(),
            SizedBox(height: ScreenUtil.getInstance().setHeight(15)),
            Container(
                height: ScreenUtil.getInstance().setHeight(800),
                child: Column(children: <Widget>[
                  Spacer(),
                  contentNormal(),
                  contentRequest(),
                  contentDetails(),
                  contentWaiting(),
                  contentOTW(),
                  contentLoading(),
                  Spacer(),
                ])),
          ]),
        ),
      ],
    );
  }

  buttonDetails(context, String buttonTitle) {
    return Container(
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
            child: Center(
              child: Text(buttonTitle == null ? 'Help' : buttonTitle),
            ),
            onTap: () {
              setState(() {
                currentProgress = Progress.waiting;
                distance = 1485;
              });
              // helpButtonOnClick(context);
            },
          )),
    );
  }

  buttonRequest(context, String buttonTitle) {
    return Container(
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
            child: Center(
              child: Text(buttonTitle == null ? 'Help' : buttonTitle),
            ),
            onTap: () {
              setState(() {
                currentProgress = Progress.details;
                distance = 990;
              });
            },
          )),
    );
  }

  buttonHelp(context, String buttonTitle) {
    return Container(
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
            child: Center(
              child: Text(buttonTitle == null ? 'Help' : buttonTitle),
            ),
            onTap: () {
              setState(() {
                currentProgress = Progress.request;
                distance = 495;
              });
              helpButtonOnClick(context);
            },
          )),
    );
  }

  colorBackground(pBar, currentProgress) {
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

  colorFont(pBar, currentProgress) {
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

  contentDetails() {
    return currentProgress == Progress.details
        ? Container(
            height: ScreenUtil.getInstance().setHeight(700),
            child: Column(children: <Widget>[
              Container(
                  child: Center(
                      child: Form(
                child: Column(children: <Widget>[
                  Text('Where are you?'),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text('Block',
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'black_label',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ))),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: _block.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => _onSelectedBlock(value),
                            value: _selectedBlock,
                          ),
                        ),
                      ])),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              'Floor',
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'black_label',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: _floor.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => _onSelectedFloor(value),
                            value: _selectedFloor,
                          ),
                        ),
                      ])),
                ]),
              ))),
              buttonDetails(context, 'Submit'),
            ]))
        : Container();
  }

  contentLoading() {
    return currentProgress == Progress.loading ? SplashScreen() : Container();
  }

  contentNormal() {
    return currentProgress == Progress.normal
        ? Container(
            height: ScreenUtil.getInstance().setHeight(700),
            child: Column(children: <Widget>[
              Spacer(),
              Container(
                  color: Colors.pink,
                  height: ScreenUtil.getInstance().setHeight(100),
                  child: AutoSizeText(
                    'If you need help, tap on the \'Help\' button. For futher assistance you may call the ',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
                  )),
              Container(
                color: Colors.blue,
                height: ScreenUtil.getInstance().setHeight(50),
                child: GestureDetector(
                    onTap: () => launch("tel://+65123456789"),
                    child: AutoSizeText("emergency hotline",
                        maxLines: 1,
                        style: TextStyle(
                            color: Color(0xFF5d74e3),
                            decoration: TextDecoration.underline,
                            fontSize: ScreenUtil.getInstance().setSp(50)))),
              ),
              SizedBox(height: ScreenUtil.getInstance().setHeight(25)),
              buttonHelp(context, 'Help'),
            ]),
          )
        : Container();
  }

  contentOTW() {
    return currentProgress == Progress.otw ? Text('otw') : Container();
  }

  contentRequest() {
    return currentProgress == Progress.request
        ? Container(
            height: ScreenUtil.getInstance().setHeight(700),
            child: Column(children: <Widget>[
              Spacer(),
              Container(
                width: ScreenUtil.getInstance().setWidth(500),
                child: AutoSizeText(
                  'Your Request is currently being Process. You may want to add more details of your current location this will help our staff to find you faster',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(35)),
                ),
              ),
              Spacer(),
              buttonRequest(context, 'More Details'),
            ]))
        : Container();
  }

  contentWaiting() {
    return currentProgress == Progress.waiting ? Text('waiting') : Container();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _block = List.from(_block)..addAll(repo.getBlock());
    setCurrentProgress();
    super.initState();
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
            color: colorBackground(pBar, currentProgress),
            padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(25)),
            child: Center(
                child: AutoSizeText(text,
                    maxLines: 1,
                    style: TextStyle(
                      color: colorFont(pBar, currentProgress),
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

  void _onSelectedBlock(String value) {
    setState(() {
      _selectedFloor = "Choose ..";
      _floor = ["Choose .."];
      _selectedBlock = value;
      _floor = List.from(_floor)..addAll(repo.getLocalByFloor(value));
    });
  }

  void _onSelectedFloor(String value) {
    _selectedFloor = value;
    setState(() => _selectedFloor = value);
  }
}
