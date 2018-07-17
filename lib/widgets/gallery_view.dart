/*.........................................................................
 . Copyright (c)
 .
 . The gallery_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 17/07/18 05:15
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends StatefulWidget {
  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<GalleryItem> _galleryItems = [];

  _refresh(List<GalleryItem> thumbnailPaths) {
    setState(() => _galleryItems = thumbnailPaths);
  }

  _pickImage() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 800.0, maxHeight: 800.0);
    if (pick != null) GalleryService().uploadImage(pick);
  }

  @override
  void initState() {
    super.initState();
    GalleryService().streamThumbnailPaths(_refresh);
  }

  @override
  Widget build(BuildContext context) {
    FloatingActionButton button = FloatingActionButton(
      child: Icon(Icons.add_a_photo),
      onPressed: _pickImage,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Photo Booth')),
      body: GridView.extent(
        maxCrossAxisExtent: 200.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _galleryItems
            .map((item) => Image.network(item.imageUrl))
            .toList(),
      ),
      floatingActionButton: button,
    );
  }
}
