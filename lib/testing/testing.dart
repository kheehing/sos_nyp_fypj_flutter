import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          child: Center(
              child: Text('Staff',
                  style: TextStyle(
                    color: Colors.grey,
                  ))),
          height: ScreenUtil.getInstance().setHeight(100),
        ),
        ListTile(
          onTap: () {
            // route to add staff
          },
          title: Center(
              child: Text(
            'Add Staff',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        ListTile(
          onTap: () {
            // route to add staff
          },
          title: Center(
              child: Text(
            'Manage Staff',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        SizedBox(
          child: Center(
              child: Text('User',
                  style: TextStyle(
                    color: Colors.grey,
                  ))),
          height: ScreenUtil.getInstance().setHeight(100),
        ),
        ListTile(
          onTap: () {
            // route to add staff
          },
          title: Center(
              child: Text(
            'Add User',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        ListTile(
          onTap: () {
            // route to add staff
          },
          title: Center(
              child: Text(
            'Manage User',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
      ],
    );
  }
}
