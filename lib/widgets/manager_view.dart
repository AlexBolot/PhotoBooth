/*.........................................................................
 . Copyright (c)
 .
 . The manager_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 04/08/18 04:00
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';
import 'package:photo_booth/models/user.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:photo_booth/services/user_service.dart';

class ManagerView extends StatefulWidget {
  @override
  _ManagerViewState createState() => _ManagerViewState();
}

class _ManagerViewState extends State<ManagerView> {
  TextEditingController _collectionNameController = TextEditingController();
  List<String> collections = [];

  @override
  void initState() {
    super.initState();
    collections = UserService.currentUser.collections;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Card(
                  elevation: 8.0,
                  margin: EdgeInsets.only(top: 16.0, bottom: 32.0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _collectionNameController,
                            decoration: InputDecoration(
                              labelText: "Code de l'évènement",
                              isDense: true,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _addCollection(),
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );

              default:
                return Card(
                  elevation: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    leading: Icon(Icons.collections_bookmark),
                    title: Text(collections[index - 1]),
                    trailing: Icon(Icons.remove_red_eye),
                    onTap: () => _loadCollection(collections[index - 1]),
                  ),
                );
            }
          },
          itemCount: collections.length + 1,
        ),
      ),
    );
  }

  _addCollection() async {
    String collectionName = _collectionNameController.text.toLowerCase().trim();
    setState(() => UserService.currentUser.collections.add(collectionName));

    UserService.addCollection(collectionName).then((_) {
      _collectionNameController.clear();
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  _loadCollection(String collectionName) async {
    GalleryService.loadCollection(collectionName);
    Navigator.of(context).pushNamed(galleryView);
  }
}
