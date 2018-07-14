/*.........................................................................
 . Copyright (c)
 .
 . The ImagePicker.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 14/07/18 11:31
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File image;

  picker() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pick != null) setState(() => image = pick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Demo Home Page')),
      body: Container(
        child: Center(
          child: image == null ? Text('Bonjour !') : Image.file(image),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          picker();
        },
      ),
    );
  }
}
