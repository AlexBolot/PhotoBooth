/*.........................................................................
 . Copyright (c)
 .
 . The guest_card.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 01:58
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';

class GuestCard extends StatefulWidget {
  @override
  _GuestCardState createState() => _GuestCardState();
}

class _GuestCardState extends State<GuestCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 125.0),
      child: Card(
        elevation: 8.0,
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
                onPressed: () => Navigator.of(context).pushNamed(guestView),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
