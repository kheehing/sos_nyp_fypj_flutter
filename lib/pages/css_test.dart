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
    return Scaffold(
      appBar: AppBar(
        title: Text('some button'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: Text('somebutton'),
    );
  }
}
