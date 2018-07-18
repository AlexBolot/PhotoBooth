/*.........................................................................
 . Copyright (c)
 .
 . The gallery_item.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 18/07/18 02:14
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryItem {
  final String userName;
  final String imageUrl;
  final String thumbnailUrl;

  GalleryItem({
    this.userName,
    this.imageUrl,
    this.thumbnailUrl,
  });

  GalleryItem.fromSnapshot(DocumentSnapshot snap)
      : userName = snap.data['userName'],
        imageUrl = snap.data['imageUrl'],
        thumbnailUrl = snap.data['thumbnailUrl'];

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'imageUrl': this.imageUrl,
      'thumbnailUrl': this.thumbnailUrl,
    };
  }
}
