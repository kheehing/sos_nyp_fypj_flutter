import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Email validator
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

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

// login validate
  void _validateAndSave() {
    if (_formKey.currentState.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((onValue) {})
          .catchError((error) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("Wrong Email or Password"),
        ));
      });
    }
  }

  // form
  Form _form() {
    return new Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          new Container(
              margin: EdgeInsets.fromLTRB(0, 85, 0, 0),
              alignment: Alignment.centerLeft,
              child: Row(children: <Widget>[
                Container(
                    child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.red,
                )),
                Align(
                    child: Text(
                  'SOS APP',
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Black_label',
                  ),
                )),
              ])),
          new Container(
            padding: EdgeInsets.fromLTRB(10, 82, 10, 130),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black45,
                    blurRadius: 20,
                  )
                ]),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: new EdgeInsets.fromLTRB(0, 150, 0, 50),
          ),
          new Container(
              margin: new EdgeInsets.fromLTRB(0, 150, 0, 50),
              child: Container(
                  child: Column(children: <Widget>[
                Container(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Black_label',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  alignment: Alignment.centerLeft,
                  margin: new EdgeInsets.fromLTRB(15, 15, 0, 0),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Stack(children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            autofocus: false,
                            autocorrect: false,
                            initialValue: null,
                            decoration: new InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: validateEmail,
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              obscureText: true,
                              autofocus: false,
                              autocorrect: false,
                              initialValue: null,
                              decoration: new InputDecoration(
                                hintText: 'password',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password Can't be empty";
                                }
                              })),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 117, 0, 0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {
                                  //function forgetpassword
                                },
                                child: Text('Forget Password',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    )),
                              ))),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  //function forgetpassword
                                },
                                child: Text('Forget Password',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    )),
                              ))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 230, 0, 0),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Register');
                                },
                                child: Text('Don\'t have an account ? Sign Up',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    )),
                              ))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
                              child: ButtonTheme(
                                  minWidth: 150,
                                  height: 50,
                                  child: RaisedButton(
                                    color: Colors.blueAccent,
                                    child: Text('LogIn',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: _validateAndSave,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10)),
                                  )))),
                    ])),
              ]))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        children: <Widget>[
          _form(),
        ],
      )),
    );
  }
}
