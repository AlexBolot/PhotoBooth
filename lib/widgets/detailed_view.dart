/*.........................................................................
 . Copyright (c)
 .
 . The detailed_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 20/07/18 03:00
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_booth/models/gallery_item.dart';

class DetailedView extends StatefulWidget {
  final GalleryItem galleryItem;

  DetailedView(this.galleryItem);

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  File _imageFile;
  String _imageUrl;
  bool _render;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.galleryItem.imageFile;
    _imageUrl = widget.galleryItem.imageUrl;
    _render = true;
  }

  @override
  Widget build(BuildContext context) {
    return _render ? Scaffold(
      backgroundColor: Colors.black,
      body: Hero(
        tag: widget.galleryItem.imageName ?? '',
        child: Stack(
          alignment: Alignment(0.0, 1.0),
          children: <Widget>[
            imageDisplay(),
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    child: Icon(Icons.arrow_back, size: 40.0),
                    onPressed: _goBack,
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    child: Icon(Icons.cloud_download, size: 40.0),
                    onPressed: () => print('asked to download'),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    child: Icon(Icons.share, size: 40.0),
                    onPressed: () => print('asked to share'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ) : Container();
  }

  Widget imageDisplay() {
    print('>> Displaying image : ${widget.galleryItem.imageName}');
    print('>> Displaying using : ${_imageFile == null ? 'Url' : 'File'}');
    return _imageFile != null
        ? Image.file(_imageFile,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center)
        : Image.network(_imageUrl,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center);
  }

  _goBack() {
    setState(() => _render = false);
    Navigator.of(context).pop();
  }
}
