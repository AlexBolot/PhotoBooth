/*.........................................................................
 . Copyright (c)
 .
 . The detailed_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 30/07/18 13:51
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/widgets/gallery_view.dart';
import 'package:simple_permissions/simple_permissions.dart';

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
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.cloud_download, size: 40.0),
                          onPressed: () => _download(),
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.share, size: 40.0),
                          onPressed: () => _share(),
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

  _share() {
    final channel = const MethodChannel('channel:alexandre.bolot/share_image');
    channel.invokeMethod('shareFilePath', _galleryItem.imageName);
  }

  _download() async {
    Permission permission = Permission.WriteExternalStorage;

    bool granted = await SimplePermissions.checkPermission(permission);
    print('permission is ${granted ? 'granted' : 'denied'}');

    if (!granted) {
      granted = await SimplePermissions.requestPermission(permission);
      print('permission is ${granted ? 'granted' : 'denied'}');
    }

    if (!granted) return;

    Directory externalDir = await getExternalStorageDirectory();

    Directory photoBoothDir = Directory(externalDir.path + '/PhotoBooth/');

    if (!photoBoothDir.existsSync()) photoBoothDir.createSync();

    File file = File(photoBoothDir.path + _galleryItem.imageName);

    file.createSync();

    file.writeAsBytes(_galleryItem.imageFile.readAsBytesSync());
  }
}
