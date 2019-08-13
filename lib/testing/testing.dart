import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/charts.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      height: ScreenUtil.getInstance().setHeight(500),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          // color: Colors.green,
          child: Container(
            height: ScreenUtil.getInstance().setHeight(500),
            width: ScreenUtil.getInstance().setWidth(750),
            decoration: BoxDecoration(
              // color: Colors.pink,
              borderRadius:
                  BorderRadius.circular(ScreenUtil.getInstance().setSp(50)),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  height: ScreenUtil.getInstance().setHeight(500),
                  width: ScreenUtil.getInstance().setWidth(1000),
                  child: GroupedBarChart.withSampleData(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
