/*.........................................................................
 . Copyright (c)
 .
 . The home_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 22:17
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:photo_booth/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  TextEditingController _collectionNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 95.0),
            child: Image.asset('assets/PhotoBoothLogo.png', fit: BoxFit.cover),
          ),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: TextField(
                    controller: _collectionNameController,
                    decoration: InputDecoration(
                      labelText: "Code de l'évènement",
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 14.0),
                ),
                Container(
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      labelText: "Nom et Prénom",
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 14.0),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "C'est parti !",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _login,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _collectionNameController.text = pref.getString('collectionName') ?? '';
    _userNameController.text = pref.getString('userName') ?? '';
  }

  _login() async {
    String code = _collectionNameController.text.toLowerCase().trim();
    String name = _userNameController.text.toLowerCase().trim();

    bool success = await UserService.loginAnonymously(code, name);

    if (success) Navigator.of(context).pushNamed(galleryView);
  }
}
