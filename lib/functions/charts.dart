import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        new charts.SeriesLegend(position: charts.BehaviorPosition.end),
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<Floor, String>> _createSampleData() {
    List<Floor> test() {
      var data = new List<Floor>();
      var collection =
          Firestore.instance.collection('help.attended').getDocuments();
      collection.then((col) {
        col.documents.forEach((doc) {
          // print('Doc.block: ${doc.data['details']['block']}');
          data.add(Floor(doc.data['details']['block'], 10));
        });
        print('data ( inside ) : $data');
      });
      return data;
    }

    final floor1 = [
      new Floor('B', 5),
      new Floor('H', 2),
      new Floor('S', 9),
      new Floor('P1', 7),
    ];

    final floor2 = [
      new Floor('B', 5),
      new Floor('L', 5),
      new Floor('A', 1),
      new Floor('N', 2),
    ];

    final floor3 = [
      new Floor('B', 8),
      new Floor('M', 1),
      new Floor('F', 5),
      new Floor('G', 4),
    ];

    return [
      new charts.Series<Floor, String>(
        id: 'Floor 1',
        domainFn: (Floor floor, _) => floor.block,
        measureFn: (Floor floor, _) => floor.floor,
        data: floor1,
      ),
      new charts.Series<Floor, String>(
        id: 'Floor 2',
        domainFn: (Floor floor, _) => floor.block,
        measureFn: (Floor floor, _) => floor.floor,
        data: floor2,
      ),
      new charts.Series<Floor, String>(
        id: 'Floor 3',
        domainFn: (Floor floor, _) => floor.block,
        measureFn: (Floor floor, _) => floor.floor,
        data: floor3,
      ),
    ];
  }
}

/// Sample ordinal data type.
class Floor {
  final String block;
  final int floor;

  Floor(this.block, this.floor);
}
