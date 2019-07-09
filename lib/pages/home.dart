import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/homeStatus-function.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/functions/splashScreen.dart';
import 'package:sosnyp/main.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

//// Status : null (Normal); request; details; waiting; OTW;
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1350, allowFontScaling: true);
    title = "SOS NYP";
    return Column(
      children: <Widget>[
        Container(
            height: ScreenUtil.getInstance().setHeight(825),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('help.current')
                  .document(currentUser)
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                } else if (snapshot.data.data == null) {
                  return statusNormal();
                } else if (snapshot.data['statusPrevious'] == "OTW" &&
                    snapshot.data['status'] == "details") {
                  return statusOTWDetails(context);
                } else {
                  switch (snapshot.data['status']) {
                    case "normal":
                      return statusNormal();
                      break;
                    case "request":
                      return statusRequest(context);
                      break;
                    case "details":
                      return statusDetails(context);
                      break;
                    case "OTW":
                      return statusOTW(context);
                      break;
                    case "waiting":
                      return statusWaiting(context);
                      break;
                    default:
                      return statusNormal();
                      break;
                  }
                }
              },
            )),
        button(context),
        Spacer(),
      ],
    );
  }
}
