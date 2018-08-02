/*.........................................................................
 . Copyright (c)
 .
 . The user_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 01:14
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String collectionName;
  static String userName;

  static Future<bool> login(String code, String name) async {
    if (code.isNotEmpty && name.isNotEmpty) {
      await _auth.signInAnonymously();

      collectionName = code;
      userName = name;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', userName);
      await prefs.setString('collectionName', collectionName);

      return true;
    }
    return false;
  }
}
