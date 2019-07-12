import 'package:sosnyp/functions/homepage-campus-model.dart';

class Repository {
  List _blockFloor = [
    {
      "block": "A",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "B",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "C",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "D",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "D1",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "E",
      "floor": ["1", "2", "3"]
    },
    {
      "block": "F",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "G",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "H",
      "floor": ["2", "3", "4", "5", "6"]
    },
    {
      "block": "J",
      "floor": ["2", "3", "4", "5", "6"]
    },
    {
      "block": "K",
      "floor": ["2", "3", "4", "5", "6"]
    },
    {
      "block": "L",
      "floor": ["2", "3", "4", "5", "6"]
    },
    {
      "block": "M",
      "floor": ["2", "3", "4", "5", "6"]
    },
    {
      "block": "N",
      "floor": ["2", "3", "4", "5", "6"]
    },
    {
      "block": "N1",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "P",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "P1",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "Q",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "R",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "s",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "T",
      "floor": ["1", "2", "3", "4"]
    },
    {
      "block": "Others",
      "floor": ["Stadium", "Basketball Court", "HockeyField"]
    },
    {
      "block": "No Idea",
      "floor": ["1", "2", "3", "4", "5", "6", "7", "8", "No Idea"]
    },
  ];

  List<Map> getAll() => _blockFloor;

  List<String> getBlock() => _blockFloor
      .map((map) => Model.fromJson(map))
      .map((item) => item.block)
      .toList();

  getLocalByFloor(String block) => _blockFloor
      .map((map) => Model.fromJson(map))
      .where((item) => item.block == block)
      .map((item) => item.floor)
      .expand((i) => i)
      .toList();
}
