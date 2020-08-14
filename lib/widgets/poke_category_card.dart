import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/models/category.dart';
import 'package:pokedex/utils/app_imgs.dart';

class PokeCategoryCard extends StatelessWidget {
  PokeCategoryCard({this.category, Key key, this.onPress}) : super(key: key);

  final Category category;
  final Function onPress;

  _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            category.name,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
    );
  }

  _buildDecoration(double itemHeight) {
    return [
      Positioned(
        top: -itemHeight * 0.616,
        left: -itemHeight * 0.53,
        child: CircleAvatar(
          radius: itemHeight * 1.03 / 2,
          backgroundColor: Colors.white.withOpacity(0.14),
        ),
      ),
      Positioned(
          top: -itemHeight * 0.16,
          right: -itemHeight * 0.25,
          child: Center(
            child: Image(
              image: AppImgs.pokeball,
              width: itemHeight * 1.388,
              height: itemHeight * 1.388,
              color: Colors.white.withOpacity(0.14),
            ),
          ))
    ];
  }

  Widget _buildShadow(double itemWidth) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: itemWidth,
          height: 11,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: category.color,
                offset: Offset(0, 3),
                blurRadius: 23)
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final itemHeight = constraint.maxHeight;
        final itemWidth = constraint.maxWidth;

        return Stack(
          children: [
            _buildShadow(itemWidth),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(0),
              color: category.color,
              splashColor: Colors.white10,
              highlightColor: Colors.white10,
              elevation: 0,
              highlightElevation: 2,
              disabledColor: category.color,
              onPressed: onPress,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    _buildCardContent(),
                    ..._buildDecoration(itemHeight)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
