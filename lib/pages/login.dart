import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/login-functions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> loginScaffoldKey = new GlobalKey<ScaffoldState>();
  bool currentState = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1350, allowFontScaling: true);
    return new Scaffold(
      key: loginScaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 90.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(". . . _ _ _ . . .",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(100),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(90)),
                  currentState == true ? LoginFormCard() : RegisterFormCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      currentState == true
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  currentState = false;
                                });
                              },
                              child: Text("New User? SignUp",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF5d74e3),
                                      fontFamily: "Poppins-Bold")),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  currentState = true;
                                });
                              },
                              child: Text('Back to Login',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xff5d74e3),
                                      fontFamily: "Poppins-Bold")),
                            ),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().setHeight(20)),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );
}
