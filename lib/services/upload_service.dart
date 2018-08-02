/*.........................................................................
 . Copyright (c)
 .
 . The upload_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 02:43
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as plugin;
import 'package:path_provider/path_provider.dart';
import 'package:photo_booth/config.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:photo_booth/services/user_service.dart';

class UploadService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final Firestore _firestore = Firestore.instance;

  static uploadGalleryItem(File fullImage) async {
    String fileName = '${UserService.userName}${DateTime.now()
        .toIso8601String()}';

    int startTime = getTime();

    plugin.Image decodedImage = plugin.decodeJpg(fullImage.readAsBytesSync());

    print('>> decoded image in ${(getTime() - startTime) / 1000}s');

    File thumbnail = await _generateThumbnail(decodedImage, fileName);

    String thumbnailUrl = await _uploadThumbnail(thumbnail, fileName);

    String imageUrl = await _uploadImage(fullImage, fileName);

    GalleryItem item = GalleryItem(
      userName: UserService.userName,
      imageName: fileName,
      thumbnailUrl: thumbnailUrl,
      imageUrl: imageUrl,
    );

    GalleryService.loadedThumbnails[UserService.userName] = thumbnail;
    GalleryService.loadedImages[UserService.userName] = fullImage;
    GalleryService.galleryItems.add(item);

    _firestore
        .collection(UserService.collectionName)
        .document()
        .setData(item.toMap());
  }

  static Future<File> _generateThumbnail(
      plugin.Image image, String fileName) async {
    int startTime = getTime();

    plugin.Image thumbnail = plugin.copyResize(image, 400);

    print('>> resized thumbnail in ${(getTime() - startTime) / 1000}s');

    startTime = getTime();

    Directory directory = await getApplicationDocumentsDirectory();

    File file = File(directory.path + Platform.pathSeparator + fileName)
      ..createSync()
      ..writeAsBytesSync(plugin.encodeJpg(thumbnail, quality: 70));

    print('>> created file in ${(getTime() - startTime) / 1000}s');

    return file;
  }

  static Future<String> _uploadThumbnail(
      File thumbnail, String fileName) async {
    int startTime = getTime();

    UploadTaskSnapshot uploadImage = await _storage
        .ref()
        .child('${UserService.collectionName}/Thumbnails/$fileName.jpg')
        .putFile(thumbnail)
        .future;

    print('>> uploaded thumbnail in ${(getTime() - startTime) / 1000}s');

    return uploadImage.downloadUrl.toString();
  }

  static Future<String> _uploadImage(File fullImage, String fileName) async {
    int startTime = getTime();

    UploadTaskSnapshot uploadImage = await _storage
        .ref()
        .child('${UserService.collectionName}/Images/$fileName.jpg')
        .putFile(fullImage)
        .future;

    print('>> uploaded full size image in ${(getTime() - startTime) / 1000}s');

    return uploadImage.downloadUrl.toString();
  }
}
