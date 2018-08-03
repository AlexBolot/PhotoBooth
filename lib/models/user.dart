/*.........................................................................
 . Copyright (c)
 .
 . The user.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 04:26
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  List<String> collections = [];
  String userId;
  String userName;
  String email;
  String password;

  User(this.userName, {this.email, this.password});

  User.fromMap(DocumentSnapshot snap) {
    snap.data['collections'].forEach((item) => collections.add(item.toString()));
    userName = snap.data['userName'];
    email = snap.data['email'];
    userId = snap.documentID;
  }

  Map<String, dynamic> toMap() {
    return {
      'collections': collections,
      'userName': userName,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User{userName: $userName, email: $email, collections: $collections}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          collections == other.collections &&
          userName == other.userName &&
          email == other.email;

  @override
  int get hashCode => collections.hashCode ^ userName.hashCode ^ email.hashCode;
}
