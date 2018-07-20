/*.........................................................................
 . Copyright (c)
 .
 . The gallery_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 20/07/18 01:42
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as plugin;

class GalleryService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final Firestore _firestore = Firestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final HttpClient httpClient = HttpClient();
  static String _collectionName;
  static String _userName;

  List<GalleryItem> _galleryItems = [];

  Future<bool> login(String code, String name) async {
    if (code.isNotEmpty && name.isNotEmpty) {
      await _auth.signInAnonymously();

      _collectionName = code;
      _userName = name;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _userName);
      await prefs.setString('collectionName', _collectionName);

      return true;
    }
    return false;
  }

  streamThumbnailPaths(void callback(List<GalleryItem> items)) {
    _firestore.collection(_collectionName).snapshots().listen((querySnapshot) {
      _galleryItems.clear();

      print('>> found ${querySnapshot.documents.length} picture(s)');

      querySnapshot.documents.forEach((document) {
        _galleryItems.add(GalleryItem.fromSnapshot(document));
      });

      callback(_galleryItems);
    });
  }

  mainUpload(File fullImage) async {
    String fileName = '$_userName${DateTime.now().toIso8601String()}';

    int startTime = _getTime();

    plugin.Image thumbnail = plugin.decodeJpg(fullImage.readAsBytesSync());

    print('>> decoded image in ${(_getTime() - startTime) / 1000}s');

    DocumentReference ref = await uploadThumbnail(thumbnail, fileName);

    uploadImage(fullImage, ref, fileName);
  }

  Future uploadThumbnail(plugin.Image thumbnail, String fileName) async {
    int startTime = _getTime();

    thumbnail = plugin.copyResize(thumbnail, 400);

    print('>> resized thumbnail in ${(_getTime() - startTime) / 1000}s');

    File file = await createFile(thumbnail, fileName);

    startTime = _getTime();

    UploadTaskSnapshot uploadImage = await _storage
        .ref()
        .child('$_collectionName/Thumbnails/$fileName.jpg')
        .putFile(file)
        .future;

    GalleryItem galleryItem = GalleryItem(
      userName: _userName,
      thumbnailUrl: uploadImage.downloadUrl.toString(),
    );

    _galleryItems.add(galleryItem);

    DocumentReference ref = _firestore.collection(_collectionName).document();

    await ref.setData(galleryItem.toMap());

    print('>> uploaded thumbnail in ${(_getTime() - startTime) / 1000}s');

    return ref;
  }

  Future<File> createFile(plugin.Image image, String fileName) async {
    int startTime = _getTime();

    Directory directory = await getApplicationDocumentsDirectory();

    File file = File(directory.path + Platform.pathSeparator + fileName)
      ..createSync()
      ..writeAsBytesSync(plugin.encodeJpg(image, quality: 70));

    print('>> created file in ${(_getTime() - startTime) / 1000}s');

    return file;
  }

  uploadImage(File fullImage, DocumentReference ref, String fileName) async {
    int startTime = _getTime();

    UploadTaskSnapshot uploadImage = await _storage
        .ref()
        .child('$_collectionName/Images/$fileName.jpg')
        .putFile(fullImage)
        .future;

    ref.updateData({
      'imageUrl': uploadImage.downloadUrl.toString(),
      'imageName': '$fileName.jpg',
    });

    print('>> uploaded full size image in ${(_getTime() - startTime) / 1000}s');
  }

  _getTime() => DateTime.now().millisecondsSinceEpoch;

  Future<File> downloadFile(String url, String filename) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);

    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');

    return await file.writeAsBytes(bytes);
  }
}
