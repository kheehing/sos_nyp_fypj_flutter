import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
          child: Center(
              child: Text('Staff',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil.getInstance().setSp(50),
                  ))),
          height: ScreenUtil.getInstance().setHeight(60),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/AddStaff');
          },
          title: Center(
              child: Text(
            'Add Staff',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/ManageStaff');
          },
          title: Center(
              child: Text(
            'Manage Staff',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        Container(
          child: Center(
              child: Text('User',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil.getInstance().setSp(50),
                  ))),
          height: ScreenUtil.getInstance().setHeight(60),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/AddUser');
          },
          title: Center(
              child: Text(
            'Add User',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/ManageUser');
          },
          title: Center(
              child: Text(
            'Manage User',
            style: TextStyle(fontWeight: FontWeight.w900),
          )),
        ),
        Spacer(),
      ],
    );
  }
}
