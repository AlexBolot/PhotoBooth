/*.........................................................................
 . Copyright (c)
 .
 . The main.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 14/07/18 00:37
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/widgets/camera_view.dart';
import 'package:photo_booth/widgets/gallery_view.dart';
import 'package:photo_booth/widgets/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeView(),
        '/HomeView': (context) => HomeView(),
        '/GalleryView': (context) => GalleryView(),
        '/CameraView': (context) => CameraView(),
      },
    );
  }
}
