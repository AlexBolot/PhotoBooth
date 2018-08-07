/*.........................................................................
 . Copyright (c)
 .
 . The guest_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 04/08/18 13:49
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:photo_booth/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestView extends StatefulWidget {
  @override
  createState() => _GuestViewState();
}

class _GuestViewState extends State<GuestView> {
  TextEditingController _collectionNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    GalleryService.loadCollectionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 80.0),
            child: Image.asset('assets/PhotoBoothLogo.png', fit: BoxFit.cover),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: TextFormField(
                      validator: mustExist,
                      controller: _collectionNameController,
                      decoration: InputDecoration(
                        labelText: "Code de l'évènement",
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 14.0),
                  ),
                  Container(
                    child: TextFormField(
                      validator: notEmpty,
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) _login();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loadPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _collectionNameController.text = pref.getString('collectionName') ?? '';
      _userNameController.text = pref.getString('userName') ?? '';
    });
  }

  _login() async {
    String collectionName = _collectionNameController.text.toLowerCase().trim();
    String userName = _userNameController.text.toLowerCase().trim();

    bool success = await UserService.loginAnonymously(collectionName, userName);

    if (success) Navigator.of(context).pushNamed(galleryView);
  }
}
