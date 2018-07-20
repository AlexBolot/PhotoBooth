/*.........................................................................
 . Copyright (c)
 .
 . The gallery_item.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 20/07/18 02:45
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_booth/services/gallery_service.dart';

class GalleryItem {
  String userName;
  String imageUrl;
  String thumbnailUrl;
  String imageName;
  File imageFile;

  GalleryItem({
    this.userName,
    this.imageUrl,
    this.thumbnailUrl,
    this.imageName,
  });

  GalleryItem.fromSnapshot(DocumentSnapshot snap) {
    this.userName = snap.data['userName'];
    this.imageUrl = snap.data['imageUrl'];
    this.thumbnailUrl = snap.data['thumbnailUrl'];
    this.imageName = snap.data['imageName'];

    GalleryService()
        .downloadFile(this.imageUrl, this.imageName)
        .then((image) => imageFile = image);
  }

  Map<String, dynamic> toMap() => {
        'userName': this.userName,
        'imageUrl': this.imageUrl,
        'thumbnailUrl': this.thumbnailUrl,
        'imageName': this.imageName,
      };
}
