import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key key, this.title}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Test'),
          ],
        ),
      ),
    );
  }
}
