/*.........................................................................
 . Copyright (c)
 .
 . The account_view.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 00:49
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

import 'package:flutter/material.dart';
import 'package:photo_booth/widgets/minor_widgets/guest_card.dart';
import 'package:photo_booth/widgets/minor_widgets/manager_card.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 95.0),
            child: Image.asset('assets/PhotoBoothLogo.png', fit: BoxFit.cover),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 470.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GuestCard(),
                  ManagerCard(),
                ],
              ),
            ),
            //SignUpCard(),
          ],
        ),
      ),
    );
  }
}
