/*.........................................................................
 . Copyright (c)
 .
 . The user_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 04/08/18 18:46
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_booth/models/user.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static String userName;
  static User currentUser;

  static Future<bool> loginAnonymously(
      String collectionName, String userName) async {
    if (collectionName.isNotEmpty && userName.isNotEmpty) {
      bool hasCollection = await GalleryService.hasCollection(collectionName);

      if (hasCollection) {
        await _auth.signInAnonymously();

        GalleryService.collectionName = collectionName;
        UserService.userName = userName;

        return true;
      }
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

      currentUser = User.fromMap(documentSnapshot);
      userName = currentUser.userName;

      return true;
    }
    return false;
  }

  static Future<bool> signUpUser(User user) async {
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

  static Future<bool> addCollection(String collectionName) async {
    if (collectionName.isNotEmpty) {
      _firestore
          .collection('Users')
          .document(currentUser.userId)
          .updateData({'collections': currentUser.collections});

      return true;
    }
    return false;
  }
}
