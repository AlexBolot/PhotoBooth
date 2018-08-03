/*.........................................................................
 . Copyright (c)
 .
 . The user_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 01:32
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_booth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static String collectionName;
  static String userName;
  static User currentUser;

  static Future<bool> loginAnonymously(String code, String name) async {
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

  static Future<bool> loginEmail(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      FirebaseUser firebaseUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot documentSnapshot =
          await _firestore.collection('Users').document(firebaseUser.uid).get();

      currentUser = User.fromMap(documentSnapshot.data);

      return true;
    }
    return false;
  }

  static Future<void> signUpUser(User user) async {
    if (user.email.isNotEmpty && user.password.isNotEmpty) {
      FirebaseUser firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      _firestore
          .collection('Users')
          .document(firebaseUser.uid)
          .setData(user.toMap());

      currentUser = user;

      return true;
    }
    return false;
  }
}
