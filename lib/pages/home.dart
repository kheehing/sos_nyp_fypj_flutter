import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
// import 'profile.dart'; //ProfilePage() testing can delete

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('Exit this application?'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                new FlatButton(
                  child: new Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
      ) ??
      false;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double thisWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: Center(
            child: Container(
              margin: EdgeInsets.all(10),
          width: thisWidth,
          height: thisWidth-20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99999),
            border: new Border.all(
              color: Colors.white70,
              width: 10,
            ),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.9
                ],
                colors: [
                  Color.fromRGBO(255, 0, 0, 10),
                  Color.fromRGBO(255, 0, 0, 100),
                ]),
          ),
          child: Center(
              child: Text(
            'Help',
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              fontSize: 100,
              color: Colors.white70,
            ),
          )),
        )),
      ),
    );
  }
}
