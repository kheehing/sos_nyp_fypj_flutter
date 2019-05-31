import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
          children: <Widget>[
            // LOGO
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    //Icon
                    child: Text('Icon'),
                  ),
                  SizedBox(width: 10), // Space
                  Container(
                    //Name
                    child: Text(
                      'EXAMPLE NAME',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Black_label',
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              margin: new EdgeInsets.fromLTRB(10, 200, 10, 0),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(10, 140, 10, 130),
                    width: 500,
                    // margin: new EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                    margin: new EdgeInsets.fromLTRB(0, 50, 0, 50),
                  ),
                  new Container(
                    margin: new EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: Container(
                      child: Column(
                        children: <Widget>[
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
                            child: Column(
                              children: <Widget>[
                                // Login Text
                                SizedBox(height: 30.0), // Space
                                Container(
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                      fontFamily: 'Black_label',
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  margin: new EdgeInsets.fromLTRB(10, 0, 0, 0),
                                ),
                                SizedBox(height: 8.0), // Space
                                // Email TextForm
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  autocorrect: false,
                                  initialValue: '',
                                  decoration: InputDecoration(
                                    hintText: '',
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                SizedBox(height: 8.0), // Space
                                Container(
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      fontFamily: 'Black_label',
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  margin: new EdgeInsets.fromLTRB(10, 0, 0, 0),
                                ),
                                SizedBox(height: 8.0), // Space
                                // Password TextForm
                                TextFormField(
                                  autofocus: false,
                                  initialValue: '',
                                  obscureText: true,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                SizedBox(height: 0), // Space
                                Container(
                                  child: FlatButton(
                                    onPressed: () {
                                      //function
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          SizedBox(height: 0), // Space
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    // Remember me check box
                                    // Remember me check box
                                    // Remember me check box
                                    // Remember me check box
                                    // Remember me check box
                                    ),
                                Container(
                                  child: ButtonTheme(
                                    minWidth: 150,
                                    height: 50,
                                    child: RaisedButton(
                                      color: Colors.blueAccent,
                                      child: Text('Log In',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/Home');
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10)),
                                    ),
                                  ),
                                  alignment: Alignment.bottomRight,
                                ),
                                // LoginButton,
                              ],
                            ),
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          ),
                        ],
                      ),
                      decoration: new BoxDecoration(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
