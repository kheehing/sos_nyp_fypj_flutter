import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';

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
    // double thisWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Profile Test'),
          ],
        ),
      ),
    );
  }
}
