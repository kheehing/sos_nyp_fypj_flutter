import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';
import 'updateprofile_repo.dart';

class UpdateProfilePage extends StatefulWidget {
  final String title;
  const UpdateProfilePage({Key key, this.title}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => new _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedGender;

  RegExp adminRegex = new RegExp(r'^([0-9]){6}([A-Za-z]){1}$');
  TextEditingController _controllerAdmin = new TextEditingController();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerMobile = new TextEditingController();

  // For Multi dependent dropdown
  Repository repo = Repository();
  List<String> _school = ["Choose a school"];
  List<String> _course = ["Choose .."];
  String _selectedSchool = "Choose a school";
  String _selectedCourse = "Choose ..";
  @override
  void initState() {
    var _documents =
        Firestore.instance.collection('profile').document(currentUser).get();
    _documents.then((db) {
      final _name = db.data['name'];
      _controllerName.text = _name;
      final _admin = db.data['admin'];
      _controllerAdmin.text = _admin;
      final _mobile = db.data['mobile'];
      _controllerMobile.text = _mobile;
      final _schoolDB = db.data['school'];
      setState(() => _selectedSchool = _schoolDB);
      _onSelectedSchool(_schoolDB);
      final _courseDB = db.data['course'];
      setState(() => _selectedCourse = _courseDB);
      final _genderDB = db.data['gender'];
      setState(() => _selectedGender = _genderDB);
    });

    _school = List.from(_school)..addAll(repo.getSchool());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: Text('Profile'),
          leading: myLeading,
        ),
        drawer: new MyDrawer(),
        body: ListTile(
            title: Center(
                child: Form(
                    key: _formKey,
                    child: Stack(children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 215),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 30, vertical: 50),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            'Name',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Expanded(
                                          child: TextFormField(
                                              controller: _controllerName,
                                              validator: _validateName,
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'black_label',
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            'Admin',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Expanded(
                                        child: TextFormField(
                                            controller: _controllerAdmin,
                                            validator: _validateAdmin,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration()),
                                      ),
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            'Mobile',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Expanded(
                                          child: TextFormField(
                                              maxLength: 8,
                                              controller: _controllerMobile,
                                              validator: _validateMobile,
                                              keyboardType: TextInputType.phone,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'black_label',
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text('School',
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: 'black_label',
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                      Expanded(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          items: _school
                                              .map((String dropDownStringItem) {
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
                                    margin: EdgeInsets.fromLTRB(0, 230, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            'Course',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
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
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 280, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            'Gender',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Expanded(
                                          child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('Gender'),
                                        items: <String>['Male', 'Female']
                                            .map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Text(dropDownStringItem),
                                          );
                                        }).toList(),
                                        // onChanged: (value) => print(value),
                                        onChanged: (value) {
                                          _selectedGender = value;
                                          setState(
                                              () => _selectedGender = value);
                                        },
                                        value: _selectedGender,
                                      )),
                                    ])),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: RaisedButton(
                                    color: Colors.blueAccent,
                                    child: Text('Update',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    onPressed: _updateProfile))
                          ],
                        ),
                      ),
                    ])))));
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
    _selectedCourse = value;
    setState(() => _selectedCourse = value);
  }

  String _validateAdmin(String value) {
    Pattern pattern = r'^([0-9]{6})([A-Za-z]{1})$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "Admin Can't be empty";
    } else if (!regex.hasMatch(value))
      return 'Enter a Valid Admin Number';
    else
      return null;
  }

  String _validateName(String value) {
    Pattern pattern = r'\d';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "Name Can't be empty";
    } else if (regex.hasMatch(value)) {
      return 'Name Can\'t Contian numbers';
    } else
      return null;
  }

  String _validateMobile(String value) {
    if (value.isEmpty) {
      return "Mobile Can\'t be empty";
    } else if (value.length != 8) {
      return "Mobile Number must be 8 digit";
    } else
      return null;
  }

  void _updateProfile() {
    setState(() {
      var _documents =
          Firestore.instance.collection('profile').document(currentUser).get();
      _documents.then((data) {
        if (_validateSchoolCourse()) {
          if (data.data == null) {
            _addDataBase();
          } else {
            _updateDataBase();
          }
        }
      });
    });
  }

  void _addDataBase() {
    print('########################## ADDING ##########################');
    if (_formKey.currentState.validate()) {
      Firestore.instance.collection('profile').document(currentUser).setData({
        'name': _controllerName.text,
        'admin': _controllerAdmin.text.toUpperCase(),
        'mobile': _controllerMobile.text,
        'school': _selectedSchool,
        'course': _selectedCourse,
        'gender': _selectedGender,
      }).catchError((onError) {});
      Navigator.of(context).popAndPushNamed('/Profile');
    }
  }

  void _updateDataBase() {
    print('########################## UPDATING ##########################');
    if (_formKey.currentState.validate()) {
      Firestore.instance
          .collection('profile')
          .document(currentUser)
          .updateData({
        'name': _controllerName.text,
        'admin': _controllerAdmin.text.toUpperCase(),
        'mobile': _controllerMobile.text,
        'school': _selectedSchool,
        'course': _selectedCourse,
        'gender': _selectedGender,
      }).catchError((onError) {});
      Navigator.of(context).popAndPushNamed('/Profile');
    }
  }

  _validateSchoolCourse() {
    if (_selectedSchool == 'Choose a school') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                title: new Text(
                  'Select your school',
                  textAlign: TextAlign.center,
                ));
          });
    } else if (_selectedCourse == 'Choose ..') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                title: new Text(
                  'Select your course',
                  textAlign: TextAlign.center,
                ));
          });
    } else if (_selectedGender == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                title: new Text(
                  'Select your Sex',
                  textAlign: TextAlign.center,
                ));
          });
    } else
      return true;
  }
}
