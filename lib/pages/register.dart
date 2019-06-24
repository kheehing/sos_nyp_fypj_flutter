import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key key, this.title}) : super(key: key);

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  TextEditingController _controllerCfmPass = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

// login validate
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: _form(),
    );
  }

  String validateCfmPass(String value) {
    if (value.isEmpty) {
      return "Password Can't be empty";
    } else if (value != _controllerPass.text)
      return 'Enter the same password';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email Can't be empty";
    } else if (!regex.hasMatch(value))
      return 'Enter a Valid Email';
    else
      return null;
  }

  Form _form() {
    return Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0),
              child: Text('Email'),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _controllerEmail,
                validator: validateEmail,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Text('Password'),
            ),
            Container(
              margin: EdgeInsets.only(top: 95),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controllerPass,
                  obscureText: false,
                  autofocus: false,
                  autocorrect: false,
                  initialValue: null,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password Can't be empty";
                    } else
                      return null;
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 160),
              child: Text('Confirmed Password'),
            ),
            Container(
              margin: EdgeInsets.only(top: 175),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controllerCfmPass,
                  obscureText: false,
                  autofocus: false,
                  autocorrect: false,
                  initialValue: null,
                  validator: validateCfmPass),
            ),
            Container(
                alignment: Alignment(0.9, -0.1),
                child: RaisedButton(
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _validateAndSave();
                  },
                  color: Colors.blue,
                ))
          ]),
        ));
  }

  void _validateAndSave() {
    if (_formKey.currentState.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPass.text)
          .whenComplete(() {
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }
}
