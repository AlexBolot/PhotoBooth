/*.........................................................................
 . Copyright (c)
 .
 . The thumbnail.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 03:41
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/models/gallery_item.dart';
import 'package:photo_booth/widgets/detailed_view.dart';

class Thumbnail extends StatefulWidget {
  final GalleryItem item;

  Thumbnail(this.item);

  @override
  _ThumbnailState createState() => _ThumbnailState();
}

class _ThumbnailState extends State<Thumbnail> {
  VoidCallback _refresh() {
    setState(() {});
    return null;
  }

  @override
  void initState() {
    super.initState();
    widget.item.subscribe(_refresh);
  }

  @override
  void dispose() {
    super.dispose();
    widget.item.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.thumbnailFile == null) return Card();
    return GestureDetector(
      onTap: () => _onTap(widget.item),
      child: Card(
        elevation: widget.item.imageFile == null ? 0.0 : 8.0,
        child: Image.file(
          widget.item.thumbnailFile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _onTap(GalleryItem item) {
    if (widget.item.imageFile != null)
      Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (context) => DetailedView(widget.item)));
  }
}
