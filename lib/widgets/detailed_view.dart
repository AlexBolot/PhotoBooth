/*.........................................................................
 . Copyright (c)
 .
 . The detailed_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 02:29
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/services/gallery_service.dart';
import 'package:photo_booth/widgets/gallery_view.dart';
import 'package:simple_permissions/simple_permissions.dart';

class DetailedView extends StatefulWidget {
  final GalleryItem item;

  DetailedView(this.item);

  @override
  _DetailedViewState createState() => _DetailedViewState(item);
}

class _DetailedViewState extends State<DetailedView> {
  bool _render;
  double lastDelta;
  GalleryItem item;

  _DetailedViewState(this.item);

  @override
  void initState() {
    super.initState();
    _render = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!_render) return Container();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment(0.0, 1.0),
        children: <Widget>[
          GestureDetector(
            onDoubleTap: _goBack,
            onHorizontalDragUpdate: _updateLastDrag,
            onVerticalDragEnd: (details) => _goBack(),
            onHorizontalDragEnd: (details) => _handleHorizDrag(),
            child: imageDisplay(),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: null,
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.save, size: 40.0),
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
    );
  }

  Widget imageDisplay() {
    print('>> Displaying ${item.imageFile == null
        ? 'Url of'
        : 'File'} : ${item.imageName}');
    return item.imageFile != null
        ? Image.file(item.imageFile,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center)
        : Image.network(item.imageUrl,
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
    GalleryItem previous = GalleryService.getPrevious(item);

    if (previous != null)
      setState(() => item = previous);
    else
      _goBack();
  }

  _getNext() {
    GalleryItem next = GalleryService.getNext(item);

    if (next != null)
      setState(() => item = next);
    else
      _goBack();
  }

  _goBack() {
    setState(() => _render = false);
    Navigator.of(context).pop();
  }

  _share() {
    final channel = const MethodChannel('channel:alexandre.bolot/share_image');
    channel.invokeMethod('shareFilePath', item.imageName);
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

    print('ExtDir path : $externalDir');

    Directory photoBoothDir = Directory(externalDir.path + '/PhotoBooth/');

    print('PhotoBooth path : $photoBoothDir');

    if (!photoBoothDir.existsSync()) {
      print("PhotoBooth doesn't exist !");
      photoBoothDir.createSync();
    } else {
      print("PhotoBooth exists !");
    }
    File file = File(photoBoothDir.path + item.imageName);

    file.createSync();

    file.writeAsBytes(item.imageFile.readAsBytesSync());

    _goBack();
  }
}
