/*.........................................................................
 . Copyright (c)
 .
 . The gallery_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 22/07/18 03:34
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_booth/widgets/detailed_view.dart';

List<GalleryItem> galleryItems = [];

class GalleryView extends StatefulWidget {
  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  _refresh(List<GalleryItem> thumbnailPaths) {
    setState(() => galleryItems = thumbnailPaths);
  }

  _pickImage() async {
    File pick = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1024.0, maxWidth: 1024.0);

    if (pick != null) GalleryService().mainUpload(pick);
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
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        maxCrossAxisExtent: 200.0,
        children: galleryItems.map((item) {
          if (item.thumbnailUrl == null) return Container();
          return Hero(
            tag: item.imageName ?? '',
            child: GestureDetector(
              onTap: () => _goToDetailedView(item),
              child: Card(
                elevation: 8.0,
                child: Image.network(
                  item.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: button,
    );
  }

  _goToDetailedView(GalleryItem item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailedView(galleryItems.indexOf(item));
    }));
  }
}
