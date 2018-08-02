/*.........................................................................
 . Copyright (c)
 .
 . The gallery_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 03:35
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/services/user_service.dart';

class GalleryService {
  static final Firestore _firestore = Firestore.instance;
  static final HttpClient httpClient = HttpClient();

  static List<GalleryItem> galleryItems = [];
  static Map<String, File> loadedImages = {};
  static Map<String, File> loadedThumbnails = {};

  static StreamSubscription<QuerySnapshot> galleryItemsStream;

  static streamGalleryItems(VoidCallback callback()) {
    galleryItemsStream = _firestore
        .collection(UserService.collectionName)
        .snapshots()
        .listen((querySnapshot) {
      galleryItems = [];

      print('>> found ${querySnapshot.documents.length} picture(s)');

      for (DocumentSnapshot document in querySnapshot.documents) {
        galleryItems.add(GalleryItem.fromSnapshot(document));
      }

      callback();
    });
  }

  static Future downloadThumbnail(String url, String name) async {
    loadedThumbnails[url] = await _downloadFile(url, '${name}_thumbnail');
    print('>> Downloaded Thumbnail : $name');
  }

  static Future downloadImage(String url, String name) async {
    loadedImages[url] = await _downloadFile(url, '${name}_image');
    print('>> Downloaded Image : $name');
  }

  static Future<File> _downloadFile(String url, String filename) async {
    if (url != null) {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);

      String dir = (await getTemporaryDirectory()).path;

      return await File('$dir/$filename').writeAsBytes(bytes);
    }

    return null;
  }

  static int indexOf(GalleryItem item) => galleryItems.indexOf(item);

  static GalleryItem getItem(int index) => galleryItems[index];

  static disposeGalleryItemsStream() => galleryItemsStream?.cancel();
}
