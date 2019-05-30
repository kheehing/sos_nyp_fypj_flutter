import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

final email = TextFormField(
  keyboardType: TextInputType.emailAddress,
  autofocus: false,
  autocorrect: false,
  initialValue: '',
  decoration: InputDecoration(
    hintText: 'Email',
    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

final password = TextFormField(
  autofocus: false,
  initialValue: '',
  obscureText: true,
  autocorrect: false,
  decoration: InputDecoration(
    hintText: 'Password',
    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

// final loginButton = Padding(
//   padding: EdgeInsets.symmetric(vertical: 16.0),
//   child: Material(
//     borderRadius: BorderRadius.circular(25.0),
//     shadowColor: Colors.black,
//     elevation: 5.0,
//     child: RaisedButton(
//       // minWidth: 200.0,
//       // height: 42.0,
//       onPressed: () {
//         Navigator.of(context).pushNamed('/HomePage');
//       },
//       child: Text('Log In', style: TextStyle(color: Colors.black)),
//     ),
//   ),
// );

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
            email,
            SizedBox(height: 8.0),
            password,
            // loginButton,
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Colors.black,
                elevation: 5.0,
                child: Text('Log In', style: TextStyle(color: Colors.black)),
              ),
              onPressed: (){
                Navigator.of(context).pushNamed('/Home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
