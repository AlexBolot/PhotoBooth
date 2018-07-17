/*.........................................................................
 . Copyright (c)
 .
 . The gallery_item.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 17/07/18 05:14
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryItem {
  final String userName;
  final String imageUrl;

  GalleryItem({
    this.userName,
    this.imageUrl,
  });

  GalleryItem.fromSnapshot(DocumentSnapshot snap)
      : userName = snap.data['userName'],
        imageUrl = snap.data['imageUrl'];

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'imageUrl': this.imageUrl,
    };
  }
}
