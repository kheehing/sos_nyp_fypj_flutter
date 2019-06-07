import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';

class UpdateProfilePage extends StatefulWidget {
  final String title;
  const UpdateProfilePage({Key key, this.title}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => new _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController _nameController = new TextEditingController();
  // TextEditingController _adminController = new TextEditingController();
  // TextEditingController _genderController = new TextEditingController();
  // TextEditingController _schoolController = new TextEditingController();
  // TextEditingController _courseController = new TextEditingController();
  // TextEditingController _mobileController = new TextEditingController();
  String _gender, _school, _course;

  // String _validate(String value) {
  //   if (value.isEmpty) {
  //     return "";
  //   } else
  //     return null;
  // }

  _updateProfile() {
    if (_formKey.currentState.validate()) {
      print('success');
    }
  }

  _getCourse(var school) {
    List<dynamic> array = [];
    switch (school.toString()) {
      case 'SIT':
        array = ['ICT', 'BFT', 'BIA', 'CDF', 'DIS', 'DIT', 'DBI', 'DFI'];
        return array;
        break;
      case 'SBM':
        array = ['DAF', 'DBF', 'DBM', 'CBP', 'FBB', 'HTM', 'MMM', 'SWM'];
        return array;
        break;
      case 'SCL':
        array = ['BPT', 'CPT', 'FSN', 'DMC', 'DMB', 'DPS', 'CGT'];
        return array;
        break;
      case 'SDN':
        array = ['DID', 'DSD', 'DIA', 'DVC'];
        return array;
        break;
      case 'SEG':
        array = [
          'CEP',
          'AAT',
          'DBE',
          'ADM',
          'ECE',
          'EEE',
          'DEB',
          'IME',
          'NMS',
          'DRM',
          'AEE',
          'AMP',
          'DPE',
          'DES',
          'MIT'
        ];
        return array;
        break;
      case 'SHS':
        array = ['DIN', 'OHT', 'DSS'];
        return array;
        break;
      case 'SIDM':
        array = ['AVE', 'DGAD', 'GDT', 'DID', 'MGD'];
        return array;
        break;
      default:
    }
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
        body: Form(
            key: _formKey,
            child: Center(
                child: Column(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(50, 100, 0, 0),
                child: Text('Image left side'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(50, 30, 0, 0),
                child: Text(
                  'Name',
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'black_label',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Text(
                  'Admin',
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'black_label',
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(0, 82, 0, 130),
                    margin: new EdgeInsets.fromLTRB(30, 30, 30, 50),
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
                    padding: EdgeInsets.all(10),
                    margin: new EdgeInsets.fromLTRB(30, 30, 30, 50),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                padding: EdgeInsets.all(10),
                                child: Stack(children: <Widget>[
                                  Container(
                                      child: Text('Gender',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'black_label',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      height: 30,
                                      child: DropdownButton<String>(
                                        value: _gender,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _gender = newValue;
                                          });
                                        },
                                        items: <String>['Male', 'Female']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        style: new TextStyle(
                                          inherit: false,
                                          color: Colors.black,
                                        ),
                                      )),
                                ])),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                padding: EdgeInsets.all(10),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: Text('School',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'black_label',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      height: 30,
                                      child: DropdownButton<String>(
                                        value: _school,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _school = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'SIT',
                                          'SBM',
                                          'SDN',
                                          'SCL',
                                          'SEG',
                                          'SHS',
                                          'SIDM'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        style: new TextStyle(
                                          inherit: false,
                                          color: Colors.black,
                                        ),
                                      )),
                                ])),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
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
                                    Container(
                                        alignment: Alignment.centerRight,
                                        height: 30,
                                        child: DropdownButton<String>(
                                          value: _course,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _course = newValue;
                                            });
                                          },
                                          items: <String>['fss','sgfs']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value));
                                          }).toList(),
                                          style: new TextStyle(
                                            inherit: false,
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
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
                                        child: Text('data',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'black_label',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text('Update Profile',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: _updateProfile)),
            ]))));
  }
}
