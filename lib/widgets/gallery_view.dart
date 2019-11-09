/*.........................................................................
 . Copyright (c)
 .
 . The gallery_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 11/9/19 9:50 PM
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_booth/services/upload_service.dart';
import 'package:photo_booth/widgets/minor_widgets/thumbnail.dart';

class GalleryView extends StatefulWidget {
  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  VoidCallback _refresh() {
    setState(() {});
    return null;
  }

  _pickImage() async {
    File pick = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1024.0, maxWidth: 1024.0);

    if (pick != null) UploadService.uploadGalleryItem(pick);
  }

  @override
  void initState() {
    super.initState();
    GalleryService.streamGalleryItems(_refresh);
  }

  @override
  void dispose() {
    super.dispose();
    GalleryService.disposeGalleryItemsStream();
  }

  @override
  Widget build(BuildContext context) {
    FloatingActionButton button = FloatingActionButton(
      child: Icon(Icons.add_a_photo),
      onPressed: _pickImage,
    );

    return Scaffold(
      appBar: AppBar(title: Text(GalleryService.collectionName)),
      body: GridView.extent(
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        maxCrossAxisExtent: 200.0,
        children: GalleryService.galleryItems.map((item) => Thumbnail(item)).toList(),
      ),
      floatingActionButton: button,
    );
  }
}
