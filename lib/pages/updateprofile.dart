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

  String _validate(String value) {
    if (value.isEmpty) {
      return "";
    } else
      return null;
  }

  _updateProfile() {
    if (_formKey.currentState.validate()) {
      print('success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Profile'),
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
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.w600))),
                                  Container(
                                      height: 30,
                                      child: TextFormField(
                                          validator: _validate,
                                          textAlign: TextAlign.center,
                                          autocorrect: false,
                                          style: TextStyle(
                                              fontFamily: 'black_label',
                                              fontSize: 15,
                                              
                                              fontWeight: FontWeight.w500))),
                                ])),
                            // Container(
                            //     margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            //     padding: EdgeInsets.all(10),
                            //     child: Row(children: <Widget>[
                            //       Expanded(
                            //           child: Text('School',
                            //               textAlign: TextAlign.left,
                            //               style: TextStyle(
                            //                   fontFamily: 'black_label',
                            //                   fontSize: 15,
                            //                   fontWeight: FontWeight.w600))),
                            //       Expanded(
                            //           child: TextField(
                            //               textAlign: TextAlign.center,
                            //               style: TextStyle(
                            //                   fontFamily: 'black_label',
                            //                   fontSize: 15,
                            //                   fontWeight: FontWeight.w500))),
                            //     ])),
                            // Container(
                            //     margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            //     padding: EdgeInsets.all(10),
                            //     child: Row(
                            //       children: <Widget>[
                            //         Expanded(
                            //             child: Text(
                            //           'Course',
                            //           textAlign: TextAlign.left,
                            //           style: TextStyle(
                            //               fontFamily: 'black_label',
                            //               fontSize: 15,
                            //               fontWeight: FontWeight.w600),
                            //         )),
                            //         Expanded(
                            //             child: Text('data',
                            //                 textAlign: TextAlign.center,
                            //                 style: TextStyle(
                            //                     fontFamily: 'black_label',
                            //                     fontSize: 15,
                            //                     fontWeight: FontWeight.w500))),
                            //       ],
                            //     )),
                            // Container(
                            //     margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                            //     padding: EdgeInsets.all(10),
                            //     child: Row(
                            //       children: <Widget>[
                            //         Expanded(
                            //             child: Text(
                            //           'Mobile Number',
                            //           textAlign: TextAlign.left,
                            //           style: TextStyle(
                            //               fontFamily: 'black_label',
                            //               fontSize: 15,
                            //               fontWeight: FontWeight.w600),
                            //         )),
                            //         Expanded(
                            //             child: Text('data',
                            //                 textAlign: TextAlign.center,
                            //                 style: TextStyle(
                            //                     fontFamily: 'black_label',
                            //                     fontSize: 15,
                            //                     fontWeight: FontWeight.w500))),
                            //       ],
                            //     )),
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
