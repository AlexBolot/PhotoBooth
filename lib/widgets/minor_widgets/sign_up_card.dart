/*.........................................................................
 . Copyright (c)
 .
 . The sign_up_card.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 17:11
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';

class SignUpCard extends StatefulWidget {
  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Pas encore de compte ?',
                  style: TextStyle(fontSize: 18.0),
                ),
                margin: EdgeInsets.only(bottom: 8.0),
              ),
              GestureDetector(
                child: Text(
                  'Je m\'inscris !',
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamed(homeView),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
