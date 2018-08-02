/*.........................................................................
 . Copyright (c)
 .
 . The manager_card.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 23:13
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';

class ManagerCard extends StatefulWidget {
  @override
  _ManagerCardState createState() => _ManagerCardState();
}

class _ManagerCardState extends State<ManagerCard> {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Compte organisateur',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Devenir organisateur : ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  GestureDetector(
                    child: Text(
                      'Je m\'inscris !',
                      style: TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () => Navigator.of(context).pushNamed(homeView),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
