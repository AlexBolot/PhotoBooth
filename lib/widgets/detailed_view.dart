/*.........................................................................
 . Copyright (c)
 .
 . The detailed_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 20/07/18 03:55
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/widgets/gallery_view.dart';

class DetailedView extends StatefulWidget {
  final int itemIndex;

  DetailedView(this.itemIndex);

  @override
  _DetailedViewState createState() => _DetailedViewState(itemIndex);
}

class _DetailedViewState extends State<DetailedView> {
  bool _render;
  GalleryItem _galleryItem;
  int itemIndex;
  double lastDelta;

  _DetailedViewState(this.itemIndex);

  @override
  void initState() {
    super.initState();
    _galleryItem = galleryItems[itemIndex];
    _render = true;
  }

  @override
  Widget build(BuildContext context) {
    return _render
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Hero(
              tag: _galleryItem.imageName ?? '',
              child: Stack(
                alignment: Alignment(0.0, 1.0),
                children: <Widget>[
                  GestureDetector(
                      onDoubleTap: _goBack,
                      onHorizontalDragUpdate: _updateLastDrag,
                      onVerticalDragEnd: (details) => _goBack(),
                      onHorizontalDragEnd: (details) => _handleHorizDrag(),
                      child: imageDisplay()),
                  Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
          )
        : Container();
  }

  Widget imageDisplay() {
    print('>> Displaying ${_galleryItem.imageFile == null
        ? 'Url of'
        : 'File'} : ${_galleryItem.imageName}');
    return _galleryItem.imageFile != null
        ? Image.file(_galleryItem.imageFile,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center)
        : Image.network(_galleryItem.imageUrl,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center);
  }

  _updateLastDrag(DragUpdateDetails details) {
    lastDelta = details.primaryDelta;
  }

  _handleHorizDrag() {
    if (lastDelta < -3.0) _getNext();
    if (lastDelta > 3.0) _getPrevious();
  }

  _handleVertDrag() {
    if (lastDelta < -3.0) _getNext();
    if (lastDelta > 3.0) _getPrevious();
  }

  _getPrevious() {
    if (itemIndex > 0)
      setState(() => _galleryItem = galleryItems[--itemIndex]);
    else
      _goBack();
  }

  _getNext() {
    int maxIndex = galleryItems.length - 1;

    if (itemIndex < maxIndex)
      setState(() => _galleryItem = galleryItems[++itemIndex]);
    else
      _goBack();
  }

  _goBack() {
    setState(() => _render = false);
    Navigator.of(context).pop();
  }
}
