import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';

class TestingPage extends StatefulWidget {
  final String title;
  const TestingPage({Key key, this.title}) : super(key: key);

  @override
  _TestingPageState createState() => new _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    var thisWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('some button'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: Stack(children: <Widget>[
          Align(
            alignment: Alignment(0, -1),
            child: Container(
              height: thisWidth / 2,
              width: thisWidth,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text('data'),
              ),
            ),
          ),
          Align(
              alignment: Alignment(0, 1),
              child: Container(
                  height: thisWidth - 10,
                  width: thisWidth,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(thisWidth),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(thisWidth),
                    child: MaterialButton(
                        onPressed: () {
                          debugPrint('test');
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(thisWidth)),
                        child: FittedBox(
                          child: Text(
                            'HELP',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 99999,
                                color: Colors.white,
                                fontFamily: 'black_label',
                                fontWeight: FontWeight.w600),
                          ),
                          fit: BoxFit.fitWidth,
                        )),
                  )))
        ]));
  }
}
