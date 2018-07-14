/*.........................................................................
 . Copyright (c)
 .
 . The home_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 14/07/18 11:33
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Photo Booth')),
      ),
      body: Center(
        child: Card(
          elevation: 8.0,
          margin: EdgeInsets.all(40.0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Code de l'évènement",
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 14.0),
                ),Container(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nom Prénom",
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 14.0),
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "C'est parti !",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/CameraView');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
