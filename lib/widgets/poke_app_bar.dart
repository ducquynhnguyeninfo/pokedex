import 'package:flutter/material.dart';

class PokeAppBar extends AppBar {
  PokeAppBar({Widget title, Widget rightButton})
      : super(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {

            },
          ),
          title: title,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 28),
              child: rightButton,
            )
          ],
        );
}
