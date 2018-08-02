/*.........................................................................
 . Copyright (c)
 .
 . The main.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 16:12
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';
import 'package:photo_booth/widgets/account_view.dart';
import 'package:photo_booth/widgets/gallery_view.dart';
import 'package:photo_booth/widgets/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[800],
        accentColor: Colors.red[400],
      ),
      routes: {
        '/': (context) => AccountView(),
        homeView: (context) => HomeView(),
        galleryView: (context) => GalleryView(),
        accountView : (context)=> AccountView(),
      },
    );
  }
}
