/*.........................................................................
 . Copyright (c)
 .
 . The config.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 01:58
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

String get accountView => '/AccountView';
String get guestView => '/GuestView';
String get galleryView => '/GalleryView';
String get detailedView => '/DetailedView';
String get managerView => '/ManagerView';

getTime() => DateTime.now().millisecondsSinceEpoch;