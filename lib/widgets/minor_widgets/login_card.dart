/*.........................................................................
 . Copyright (c)
 .
 . The login_card.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 17:11
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Compte utilisateur',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4.0),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 32.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 2.0, right: 6.0),
                    child: Center(
                      child: Icon(
                        Icons.lock,
                        size: 28.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        isDense: true,
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: RaisedButton(
                    child: Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.of(context).pushNamed(homeView),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
