/*.........................................................................
 . Copyright (c)
 .
 . The guest_loging_card.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 17:11
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';

class GuestLoginCard extends StatefulWidget {
  @override
  _GuestLoginCardState createState() => _GuestLoginCardState();
}

class _GuestLoginCardState extends State<GuestLoginCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 125.0),
      child: Card(
        elevation: 8.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Compte invité',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Se connecter',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context).pushNamed(homeView),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
