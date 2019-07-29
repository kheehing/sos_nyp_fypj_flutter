import 'package:flutter/material.dart';
import 'package:sosnyp/functions/zoom_scaffold.dart';
import 'package:sosnyp/main.dart';
import 'package:sosnyp/pages/home.dart';
import 'package:sosnyp/pages/inbox.dart';

// // X is the pageContent; Y is the popupMenu
String title, currentUserImageUrl;
var x, y, rootContext;

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var widget;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
        contentkey: scaffoldKey,
        contentScreen: Layout(
          contentBuilder: (cc) => x == null
              ? currentUserType == UserType.user
                  ? HomePage()
                  : currentUserType == UserType.staff
                      ? InboxPage()
                      : currentUserType == UserType.admin
                          ? InboxPage()
                          : InboxPage()
              : x,
        ));
  }

  @override
  void dispose() {
    x = null;
    y = null;
    title = null;
    currentUser = null;
    currentUserName = null;
    currentUserImageUrl = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    rootContext = context;
    print('The current userType is ${currentUserType.toString()}');
  }
}
