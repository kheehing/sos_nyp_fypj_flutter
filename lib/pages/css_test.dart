import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sosnyp/main.dart';
import 'package:image_picker/image_picker.dart';

class TestingPage extends StatefulWidget {
  final String title;
  const TestingPage({Key key, this.title}) : super(key: key);

  @override
  _TestingPageState createState() => new _TestingPageState();
}

// class _TestingPageState extends State<TestingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// appBar: AppBar(
//   title: Text('Test Page'),
//   leading: myLeading,
// ),
// drawer: new MyDrawer(),
//         body: Center(child: Text('TestPage')));
//   }
// }

class _TestingPageState extends State<TestingPage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
        leading: myLeading,
      ),
      drawer: new MyDrawer(),
      body: new Center(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
