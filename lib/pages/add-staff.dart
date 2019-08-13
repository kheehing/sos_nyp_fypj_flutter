import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flushbar/flushbar.dart';
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

class AddStaffPage extends StatefulWidget {
  @override
  _AddStaffPageState createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  static GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();
  final controllerEmailR = new TextEditingController();
  final controllerPasswordR = new TextEditingController();
  final controllerNameR = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Add Staff'),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(50),
              vertical: ScreenUtil.getInstance().setHeight(50),
            ),
            child: Column(
              children: <Widget>[
                Spacer(),
                Form(
                    key: registerFormKey,
                    child: Stack(children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: ScreenUtil.getInstance().setHeight(850),
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
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil.getInstance().setHeight(20),
                                    left:
                                        ScreenUtil.getInstance().setWidth(20)),
                                child: Text("Register Staff",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(45),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .6)),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.getInstance()
                                          .setHeight(100)),
                                  child: TextFormField(
                                    controller: controllerEmailR,
                                    validator: validateEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.getInstance()
                                          .setHeight(240)),
                                  child: TextFormField(
                                    controller: controllerNameR,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Name can't be empty";
                                      } else
                                        return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.getInstance()
                                          .setHeight(380)),
                                  child: TextFormField(
                                    controller: controllerPasswordR,
                                    obscureText: true,
                                    initialValue: null,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password can't be empty";
                                      } else if (value.length < 6) {
                                        return "Longer Password";
                                      } else
                                        return null;
                                    },
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil.getInstance()
                                          .setHeight(520)),
                                  child: TextFormField(
                                    obscureText: true,
                                    validator: validateCfmPass,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil.getInstance().setHeight(880)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    width:
                                        ScreenUtil.getInstance().setWidth(330),
                                    height:
                                        ScreenUtil.getInstance().setHeight(100),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xffeeeeee),
                                          tRoyalBlue,
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF6078ea)
                                                  .withOpacity(.3),
                                              blurRadius: 1.0),
                                          BoxShadow(
                                              color: Color(0xFF6078ea)
                                                  .withOpacity(.3),
                                              offset: Offset(8.0, 12.0),
                                              blurRadius: 5.0),
                                          BoxShadow(
                                              color: Color(0xFF6078ea)
                                                  .withOpacity(.3),
                                              offset: Offset(8.0, 8.0),
                                              blurRadius: 5.0)
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          _register(
                                            controllerEmailR.text,
                                            controllerPasswordR.text,
                                          );
                                        },
                                        child: Center(
                                          child: Text("Register",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  letterSpacing: 1.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ])),
                    ])),
                Spacer(),
              ],
            )));
  }

  String validateCfmPass(String value) {
    if (value.isEmpty) {
      return "Password Can't be empty";
    } else if (value != controllerPasswordR.text)
      return 'Enter the same password';
    else
      return null;
  }

  _register(String email, String password) async {
    if (registerFormKey.currentState.validate()) {
      FirebaseApp secondaryApp = await FirebaseApp.configure(
        name: 'SecondaryApp',
        options: await FirebaseApp.instance.options,
      );
      try {
        await FirebaseAuth.fromApp(secondaryApp)
            .createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseAuth.fromApp(secondaryApp).currentUser().then((onValue) {
          Firestore.instance
              .collection('profile')
              .document(onValue.uid)
              .setData({
            'enabled': true,
            'accountType': 'staff',
            'name': controllerNameR.text.toString(),
          });
        }).whenComplete(() {
          Flushbar(
            message: "Staff Creation Completed",
            margin: EdgeInsets.all(8),
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            borderRadius: 8,
            duration: Duration(seconds: 2),
          )..show(_scaffoldKey.currentContext);
        });
        await FirebaseAuth.fromApp(secondaryApp).signOut();
      } on PlatformException catch (e) {
        Flushbar(
          message: "${e.code}".replaceAll('_', ' ').replaceAll('ERROR ', ''),
          margin: EdgeInsets.all(8),
          icon: e.code == "ERROR_EMAIL_ALREADY_IN_USE"
              ? Icon(
                  Icons.email,
                  color: Colors.white,
                )
              : e.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL"
                  ? Icon(
                      Icons.supervisor_account,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
          borderRadius: 8,
          duration: Duration(seconds: 2),
        )..show(_scaffoldKey.currentContext);
      }
    }
  }
}
