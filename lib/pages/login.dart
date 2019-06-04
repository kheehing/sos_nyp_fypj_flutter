import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'auth.dart';
// import 'auth_provider.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({this.onSignedIn});
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Email validator
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    print('Empty Email');
    return "Email Can't be empty";
  } else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FormType _formType = FormType.login;

// login validate
  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      if (form.validate()) {
        return true;
      }
      return false;
    }
  }

// login validate
  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          final String userId =
              await widget.auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
          print('Signed in: $userId');
        } else {
          final String userId =
              await widget.auth.createUserWithEmailAndPassword(_emailController.text, _passwordController.text);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        children: <Widget>[
          new Form(
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
                                  // onSaved: (value) => _email = value,
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
                                    // onSaved: (value) => _password = value,
                                    decoration: new InputDecoration(
                                      hintText: 'password',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        print('Empty Password');
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
                                            decoration:
                                                TextDecoration.underline,
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
                                          child: Text('Log In',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: validateAndSubmit,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10)),
                                        )))),
                          ])),
                    ]))),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
