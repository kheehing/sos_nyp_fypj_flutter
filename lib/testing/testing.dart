import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<charts.Series<Task, String>> _seriesPieData;

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil.getInstance().setSp(10)),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius:
              BorderRadius.circular(ScreenUtil.getInstance().setSp(10))),
      height: ScreenUtil.getInstance().setHeight(500),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: charts.PieChart(
                    _seriesPieData,
                    animate: true,
                    animationDuration: Duration(milliseconds: 500),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 11),
                      )
                    ],
                    // defaultRenderer: new charts.ArcRendererConfig(
                    //     arcWidth: 100,
                    //     arcRendererDecorators: [
                    //       new charts.ArcLabelDecorator(
                    //           labelPosition: charts.ArcLabelPosition.inside)
                    //     ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorvalue;

  Task(this.task, this.taskvalue, this.colorvalue);
}

_generateData() {
  List<String> test = [
    'S',
    'S',
    'S',
    'S',
    'S',
    'S',
    'S',
    'J',
    'J',
    'J',
    'B',
    'G',
    'J',
    'J',
    'J',
    'J',
    'A',
    'O',
    'J',
  ];
  test.sort();
  print("TempList ( start ): $test");
  List<Map> tempList = new List<Map>();
  // List<dynamic> tempListContains = new List<dynamic>();
  test.forEach((data) {
    if (tempList.every((tdata) => tdata[''] == data)) {
      tempList.add({data: 1});
      // tempListContains.add(data);
      print("TempList ( inside ): $tempList");
    } else {
      // for (data in tempList) {
      //   print('for data in templst data: $data templist: $tempList');
      // }
    }
  });
  print("TempList ( final ): $tempList");

  var pieData = [
    Task('Work', 35.8, Color(0xff3366cc)),
    Task('Eat', 8.3, Color(0xff990099)),
    Task('Commute', 10.8, Color(0xff109618)),
    Task('TV', 15.6, Color(0xfffdbe19)),
    Task('Sleep', 19.2, Color(0xffff9900)),
    Task('Other', 99.3, Color(0xffdc3912)),
  ];
  _TestState()._seriesPieData.add(
    charts.Series(
      data: pieData,
      domainFn: (Task task, _) => task.task,
      measureFn: (Task task, _) => task.taskvalue,
      colorFn: (Task task, _) =>
          charts.ColorUtil.fromDartColor(task.colorvalue),
      id: "this is the ID",
      labelAccessorFn: (Task row, _) => '${row.taskvalue}',
    ),
  );
}
