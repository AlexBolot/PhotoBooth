/*.........................................................................
 . Copyright (c)
 .
 . The gallery_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 17/07/18 05:19
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class GalleryService {
  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final Firestore firestore = Firestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String collectionName;
  static String userName;

  List<GalleryItem> galleryItems = [];

  Future<bool> login(String code, String name) async {
    if (code.isNotEmpty && name.isNotEmpty) {
      _auth.signInAnonymously();

      collectionName = code;
      userName = name;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', userName);
      await prefs.setString('collectionName', collectionName);

      return true;
    }
    return false;
  }

  streamThumbnailPaths(void callback(List<GalleryItem> files)) {
    firestore.collection(collectionName).snapshots().listen((querySnapshot) {
      galleryItems.clear();

      print('found ${querySnapshot.documents.length} picture(s)');

      querySnapshot.documents.forEach((document) {
        galleryItems.add(GalleryItem.fromSnapshot(document));
      });

      callback(galleryItems);
    });
  }

  uploadImage(File fullImage) async {
    String now = DateFormat('yyyy-MM-dd').format(DateTime.now());

    UploadTaskSnapshot uploadImage = await storage
        .ref()
        .child('$collectionName/Images/$userName$now.png')
        .putFile(fullImage)
        .future;

    GalleryItem galleryItem = GalleryItem(
      userName: userName,
      imageUrl: uploadImage.downloadUrl.toString(),
    );

    await firestore
        .collection(collectionName)
        .document()
        .setData(galleryItem.toMap());
  }
}
