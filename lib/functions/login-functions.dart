import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/theme.dart';

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return "Email Can't be empty";
  } else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

class LoginFormCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormCardState();

  testLogin() {
    _LoginFormCardState().login();
  }
}

class RegisterFormCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  static GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
  final controllerEmail = new TextEditingController();
  final controllerPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Form(
        key: loginFormKey,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenUtil.getInstance().setHeight(500),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.2),
                        blurRadius: 1.0),
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.2),
                        offset: Offset(10.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.2),
                        offset: Offset(10.0, 10.0),
                        blurRadius: 5.0),
                  ]),
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Text("Login",
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(45),
                            fontFamily: "Poppins-Bold",
                            letterSpacing: .6)),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 30),
                      child: Text("Email",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(26))),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 22.5),
                      child: TextFormField(
                        controller: controllerEmail,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        initialValue: null,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12.0)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 10),
                      child: Text("Password",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(26))),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 9),
                      child: TextFormField(
                          controller: controllerPassword,
                          obscureText: true,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password Can't be empty";
                            } else
                              return null;
                          },
                          initialValue: null,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12.0))),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 7),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  print('FORGET PASSWORD FUNCTION');
                                },
                                child: Text("Forgot Password?",
                                    style: TextStyle(
                                        color: Color(0xFF5d74e3),
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil.getInstance()
                                            .setSp(28))))
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin:
                    EdgeInsets.only(top: ScreenUtil.getInstance().height / 4.5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xffeeeeee),
                                tRoyalBlue,
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    blurRadius: 1.0),
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(8.0, 12.0),
                                    blurRadius: 5.0),
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(8.0, 8.0),
                                    blurRadius: 5.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                login();
                              },
                              child: Center(
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ])),
          ],
        ));
  }

  login() {
    if (loginFormKey.currentState.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text)
          .catchError((e) {
        if (e.toString() ==
            "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)") {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Wrong Password."),
            duration: Duration(seconds: 3),
          ));
        }
        if (e.toString() ==
            "PlatformException(ERROR_TOO_MANY_REQUESTS, We have blocked all requests from this device due to unusual activity. Try again later. [ Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later ], null)") {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Too Many Request.\nTry again later"),
              duration: Duration(seconds: 2)));
        }
        debugPrint('Error: ' + e.toString());
      });
    }
  }
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  static GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();
  final controllerEmailR = new TextEditingController();
  final controllerPasswordR = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Form(
        key: registerFormKey,
        child: Stack(children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenUtil.getInstance().setHeight(560),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.2),
                    blurRadius: 1.0,
                  ),
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.2),
                      offset: Offset(10.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.2),
                      offset: Offset(10.0, 10.0),
                      blurRadius: 5.0),
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Text("Register",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(45),
                          fontFamily: "Poppins-Bold",
                          letterSpacing: .6)),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 30),
                      child: Text("Email",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(26)))),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 22.5),
                      child: TextFormField(
                        controller: controllerEmailR,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12.0)),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 10.5),
                      child: Text("Password",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(26)))),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 9.5),
                      child: TextFormField(
                          controller: controllerPasswordR,
                          obscureText: true,
                          initialValue: null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password Can't be empty";
                            } else
                              return null;
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12.0)))),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 6.25),
                      child: Text("Confirm Password",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(26)))),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().height / 5.9),
                      child: TextFormField(
                          obscureText: true,
                          validator: validateCfmPass,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12.0)))),
                ],
              ),
            ),
          ),
          Container(
              margin:
                  EdgeInsets.only(top: ScreenUtil.getInstance().height / 4.1),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(330),
                        height: ScreenUtil.getInstance().setHeight(100),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffeeeeee),
                              tRoyalBlue,
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  blurRadius: 1.0),
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(8.0, 12.0),
                                  blurRadius: 5.0),
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(8.0, 8.0),
                                  blurRadius: 5.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              register();
                            },
                            child: Center(
                              child: Text("Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ])),
        ]));
  }

  register() {
    if (registerFormKey.currentState.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: controllerEmailR.text,
        password: controllerPasswordR.text,
      )
          .catchError((e) {
        if (e.toString() ==
            "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)") {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("The email address is already in use"),
              duration: Duration(seconds: 2)));
        }
        debugPrint('Error: ' + e.toString());
      });
    }
  }

  String validateCfmPass(String value) {
    if (value.isEmpty) {
      return "Password Can't be empty";
    } else if (value != controllerPasswordR.text)
      return 'Enter the same password';
    else
      return null;
  }
}
