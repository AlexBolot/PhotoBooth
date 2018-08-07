/*.........................................................................
 . Copyright (c)
 .
 . The gallery_service.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 04/08/18 18:52
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
  static StreamSubscription<QuerySnapshot> galleryItemsStream;
  static final Firestore _firestore = Firestore.instance;
  static final HttpClient httpClient = HttpClient();

  static List<String> collectionNames = [];
  static String collectionName;
  static List<GalleryItem> galleryItems = [];
  static Map<String, File> loadedImages = {};
  static Map<String, File> loadedThumbnails = {};

  //========== Gallery Streaming ==========//

  static streamGalleryItems(VoidCallback callback()) {
    galleryItemsStream = _firestore
        .collection(collectionName)
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

  static disposeGalleryItemsStream() => galleryItemsStream?.cancel();

  //========== GalleryItem management ==========//

  static GalleryItem getNext(GalleryItem item) {
    int maxIndex = galleryItems.length - 1;
    int itemIndex = galleryItems.indexOf(item);

    return itemIndex < maxIndex ? getItem(++itemIndex) : null;
  }

  static GalleryItem getPrevious(GalleryItem item) {
    int itemIndex = galleryItems.indexOf(item);

    return itemIndex > 0 ? getItem(--itemIndex) : null;
  }

  static int indexOf(GalleryItem item) => galleryItems.indexOf(item);

  static GalleryItem getItem(int index) => galleryItems[index];

  //========== File temporary download ==========//

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

  //========== Collection management ==========//

  static loadCollectionsList() async {
    _firestore.collection('Collections').getDocuments().then((querySnapshot) {
      for (DocumentSnapshot document in querySnapshot.documents) {
        collectionNames.add(document.documentID);
      }
    });
  }

  static Future<bool> hasCollection(String collectionName) async {
    DocumentSnapshot snapshot = await _firestore
        .collection('Collections')
        .document(collectionName)
        .get();

    return snapshot.exists;
  }

  static Future loadCollection(String collectionName) async {
    bool hasCollection = await GalleryService.hasCollection(collectionName);
    GalleryService.collectionName = collectionName;

    if (!hasCollection) {
      _firestore
          .collection('Collections')
          .document(collectionName)
          .setData({'created-by': UserService.userName});
    }
  }
}
