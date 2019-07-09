import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/zoom_scaffold.dart';
import 'package:sosnyp/main.dart';
import 'package:sosnyp/pages/dashboard.dart';
import 'package:sosnyp/pages/home.dart';
import 'package:sosnyp/pages/about.dart';
import 'package:sosnyp/pages/inbox.dart';
import 'package:sosnyp/pages/profile.dart';

// X is the pageContent; Y is the popupMenu
String title, currentUserImageUrl;
var x, y, rootContext;

class RootPage extends StatefulWidget {
  changeScreen(screen, menuController) {
    title = screen.toString();
    switch (screen) {
      case 'Home':
        x = HomePage();
        y = null;
        break;
      case 'Profile':
        x = ProfilePage();
        y = ProfilePage().popupMenu(rootContext);
        break;
      case 'DashBoard':
        x = DashBoardPage();
        y = null;
        break;
      case 'Inbox':
        x = InboxPage();
        y = null;
        break;
      case 'About':
        x = AboutPage();
        y = null;
        break;
      default:
    }
  }

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
          contentBuilder: (cc) => x == null ? HomePage() : x,
        ));
  }

  Future downloadFile() async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child(currentUser);
    final imageUrl = await ref.getDownloadURL();
    setState(() {
      currentUserImageUrl = imageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    downloadFile();
    rootContext = context;
  }
}
