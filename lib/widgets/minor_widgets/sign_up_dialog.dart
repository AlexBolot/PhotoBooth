/*.........................................................................
 . Copyright (c)
 .
 . The sign_up_dialog.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 05/08/18 17:33
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/models/user.dart';
import 'package:photo_booth/config.dart';

class SignUpDialog extends StatefulWidget {
  @override
  _SignUpDialogState createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SimpleDialog(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 4.0),
                      child: Center(
                        child: Icon(
                          Icons.create,
                          size: 32.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: notEmpty,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: 'Nom Prénom',
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
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
                      child: TextFormField(
                        validator: isEmail,
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
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 2.0, right: 6.0),
                      child: Center(
                        child: Icon(
                          Icons.lock,
                          size: 28.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: validPassword,
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
                        'Valider',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate())
                          _triggerReturn(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _triggerReturn(BuildContext context) {
    String email = _emailController.text.toLowerCase().trim();
    String password = _pwdController.text.trim();
    String userName = _userNameController.text.toLowerCase().trim();

    User user = User(userName, email: email, password: password);

    Navigator.of(context).pop(user);
  }
}
