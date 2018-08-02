/*.........................................................................
 . Copyright (c)
 .
 . The gallery_item.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 02:47
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_booth/services/gallery_service.dart';

class GalleryItem {
  String userName;
  String imageUrl;
  String thumbnailUrl;
  String imageName;

  VoidCallback _callback;

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
  }

  File get imageFile {
    File result = GalleryService.loadedImages[this.imageUrl];

    if (result == null && imageUrl != null && imageName != null) {
      GalleryService
          .downloadImage(imageUrl, imageName)
          .then((_) => _notifyChanges());
    }

    return result;
  }

  File get thumbnailFile {
    File result = GalleryService.loadedThumbnails[this.thumbnailUrl];

    if (result == null && thumbnailUrl != null && imageName != null) {
      GalleryService
          .downloadThumbnail(thumbnailUrl, imageName)
          .then((_) => _notifyChanges());
    }

    return result;
  }

  subscribe(VoidCallback callback()) => _callback = callback;

  _notifyChanges() => _callback();

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'imageUrl': this.imageUrl,
      'thumbnailUrl': this.thumbnailUrl,
      'imageName': this.imageName,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryItem &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          imageName == other.imageName;

  @override
  int get hashCode => userName.hashCode ^ imageName.hashCode;
}
