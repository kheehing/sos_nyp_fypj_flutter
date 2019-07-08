class Model {
  String school;
  List<String> course;

  Model({this.school, this.course});

  Model.fromJson(Map<String, dynamic> json) {
    school = json['school'];
    course = json['course'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school'] = this.school;
    data['course'] = this.course;
    return data;
  }
}
