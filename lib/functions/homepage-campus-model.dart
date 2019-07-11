class Model {
  String block;
  List<String> floor;

  Model({this.block, this.floor});

  Model.fromJson(Map<String, dynamic> json) {
    block = json['block'];
    floor = json['floor'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['block'] = this.block;
    data['floor'] = this.floor;
    return data;
  }
}
