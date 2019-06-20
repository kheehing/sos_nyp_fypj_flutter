import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: Center(child: Text('Setting')),
    );
  }
}
