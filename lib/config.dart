/*.........................................................................
 . Copyright (c)
 .
 . The config.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 05/08/18 17:45
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/services/gallery_service.dart';

//========== Page Routes ==========//

String get accountView => '/AccountView';

String get guestView => '/GuestView';

String get galleryView => '/GalleryView';

String get detailedView => '/DetailedView';

String get managerView => '/ManagerView';

//========== FormFields Validators ==========//

RegExp emailRegExp = RegExp(
    r"^((([A-Za-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([A-Za-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([A-Za-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([A-Za-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([A-Za-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([A-Za-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([A-Za-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([A-Za-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([A-Za-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([A-Za-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

FormFieldValidator<String> notEmpty = (value) {
  if ((value ?? '').isEmpty) return 'Vous devez entrer une valeur';
};

FormFieldValidator<String> mustExist = (value) {
  String provided = notEmpty(value);
  String exists;

  if (!GalleryService.collectionNames.contains(value))
    exists = "Cet évènement n'existe pas";

  return provided ?? exists;
};

FormFieldValidator<String> isEmail = (value) {
  String provided = notEmpty(value);
  String isEmail;

  if (!emailRegExp.hasMatch(value)) isEmail = "Cet adresse n'est pas valide";

  return provided ?? isEmail;
};

FormFieldValidator<String> validPassword = (value) {
  String provided = notEmpty(value);
  String validPassword;

  if (value.length <= 6) validPassword = 'Minimum 6 charactères';

  return provided ?? validPassword;
};

//========== Others ==========//

getTime() => DateTime.now().millisecondsSinceEpoch;
