import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';
import 'updateprofile_report.dart';

class UpdateProfilePage extends StatefulWidget {
  final String title;
  const UpdateProfilePage({Key key, this.title}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => new _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedGender, _changedMobile;

  // For Multi depen
  Repository repo = Repository();
  List<String> _school = ["Choose a school"];
  List<String> _course = ["Choose .."];
  String _selectedSchool = "Choose a school";
  String _selectedCourse = "Choose ..";

  @override
  void initState() {
    _school = List.from(_school)..addAll(repo.getSchool());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Update Profile'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: Center(
          child: Stack(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                margin: new EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                      )
                    ]),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: new EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  'Mobile Number',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'black_label',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                                Expanded(
                                    child: TextField(
                                        onChanged: (value) => _changedMobile,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'black_label',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            padding: EdgeInsets.all(10),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: Text('School',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'black_label',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600))),
                              Expanded(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items:
                                      _school.map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      _onSelectedSchool(value),
                                  value: _selectedSchool,
                                ),
                              ),
                            ])),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  'Course',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'black_label',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                                Expanded(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: _course
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    // onChanged: (value) => print(value),
                                    onChanged: (value) =>
                                        _onSelectedCourse(value),
                                    value: _selectedCourse,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: RaisedButton(
                            color: Colors.blueAccent,
                            child: Text('Update Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            onPressed: _updateProfile))
                  ],
                ),
              ),
            ],
          ),
        ));
    // SafeArea(
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
    //     child: Column(
    //       children: <Widget>[
    // DropdownButton<String>(
    //   isExpanded: true,
    //   items: _school.map((String dropDownStringItem) {
    //     return DropdownMenuItem<String>(
    //       value: dropDownStringItem,
    //       child: Text(dropDownStringItem),
    //     );
    //   }).toList(),
    //   onChanged: (value) => _onSelectedSchool(value),
    //   value: _selectedSchool,
    // ),
    // DropdownButton<String>(
    //   isExpanded: true,
    //   items: _course.map((String dropDownStringItem) {
    //     return DropdownMenuItem<String>(
    //       value: dropDownStringItem,
    //       child: Text(dropDownStringItem),
    //     );
    //   }).toList(),
    //   // onChanged: (value) => print(value),
    //   onChanged: (value) => _onSelectedCourse(value),
    //   value: _selectedCourse,
    // ),
    //       ],
    //     ),
    //   ),
    // ) // WORKING
  }

  void _onSelectedSchool(String value) {
    setState(() {
      _selectedCourse = "Choose ..";
      _course = ["Choose .."];
      _selectedSchool = value;
      _course = List.from(_course)..addAll(repo.getLocalBySchool(value));
    });
  }

  void _onSelectedCourse(String value) {
    setState(() => _selectedCourse = value);
  }

  void _updateProfile() {
    if (_formKey.currentState.validate()) {
      print('success');
    }
  }
}
