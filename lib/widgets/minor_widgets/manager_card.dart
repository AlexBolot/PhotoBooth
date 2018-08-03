/*.........................................................................
 . Copyright (c)
 .
 . The manager_card.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 02:03
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_booth/config.dart';
import 'package:photo_booth/models/user.dart';
import 'package:photo_booth/services/user_service.dart';
import 'package:photo_booth/widgets/minor_widgets/sign_up_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerCard extends StatefulWidget {
  @override
  _ManagerCardState createState() => _ManagerCardState();
}

class _ManagerCardState extends State<ManagerCard> {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

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
                  onPressed: () => _login(),
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
                    onTap: () => _showSignUpPopup(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _emailController.text = pref.getString('email') ?? '';
      _pwdController.text = pref.getString('password') ?? '';
    });
  }

  _login() async {
    String email = _emailController.text.toLowerCase().trim();
    String password = _pwdController.text.trim();

    bool success = await UserService.loginEmail(email, password);

    if (success) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', email);
      pref.setString('password', password);

      Navigator.of(context).pushNamed(guestView);
    }
  }

  _showSignUpPopup() async {
    User user = await showDialog<User>(
      context: context,
      builder: (BuildContext context) => SignUpDialog(),
    );

    if (user != null) UserService.signUpUser(user);
  }
}
