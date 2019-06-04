import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sosnyp/main.dart';
import 'profile.dart'; //ProfilePage() testing can delete

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Do you want to exit this application?'),
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double thisWidth = MediaQuery.of(context).size.width;
    double thisHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: thisHeight / 4),
              Container(
                height: thisWidth,
                width: thisWidth,
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    body: TabBarView(
                      children: <Widget>[
                        // Help button
                        Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: new Border.all(
                              color: Colors.white70,
                              width: 10,
                            ),
                            gradient: LinearGradient(
                              // Where the linear gradient begins and ends
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              // Add one stop for each color. Stops should increase from 0 to 1
                              stops: [0.1, 0.9],
                              colors: [
                                // Colors are easy thanks to Flutter's Colors class.
                                Color.fromRGBO(255, 0, 0, 10),
                                Color.fromRGBO(255, 0, 0, 100),
                              ],
                            ),
                          ),
                          child: new FlatButton(
                            child: Text(
                              'HELP',
                              style: TextStyle(
                                fontSize: 100,
                                fontFamily: 'Righteous',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textColor: Colors.white,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );
                            },
                          ),
                        ),
                        // Detailed Help button
                        Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: new Border.all(
                              color: Colors.white70,
                              width: 10,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0.1, 0.9],
                              colors: [
                                Color.fromRGBO(0, 0, 255, 10),
                                Color.fromRGBO(0, 0, 255, 100),
                              ],
                            ),
                          ),
                          child: new FlatButton(
                            child: Text(
                              'Detailed Help',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 90,
                                fontFamily: 'Righteous',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textColor: Colors.white,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'For detailed help swipe left >>',
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  style: TextStyle(fontSize: thisWidth / 30),
                ),
                padding: EdgeInsets.fromLTRB(thisWidth / 2.4, 0, 0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
