import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/utils/app_colors.dart';
import 'package:pokedex/utils/app_imgs.dart';

class PokeContainer extends StatelessWidget {
  final children;
  final height;
  final decoration;
  final appBar;

  const PokeContainer({
    Key key,
    @required this.children,
    this.height,
    this.decoration,
    this.appBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final pokeSize = screenSize.width * 0.66;
    final pokeTop = -(screenSize.width) * 0.154;
    final pokeRight = -(screenSize.width) * 0.23;
    final appBarTop = pokeSize / 2 + pokeTop - IconTheme.of(context).size / 2;

    return Container(
      width: screenSize.width,
      decoration: decoration,
//    color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: pokeTop,
            right: pokeRight,
            child: Image(
              image: AppImgs.pokeball,
              width: pokeSize,
              height: pokeSize,
              color: AppColors.black.withOpacity(0.05),
            ),
          ),
//          Column(
//            mainAxisSize: MainAxisSize.max,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: [
//              if (appBar)
//                Padding(
//                  padding: EdgeInsets.only(left: 26, right: 26, top: appBarTop),
//                  child: Row(
//                    mainAxisSize: MainAxisSize.max,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      InkWell(
//                        child: Icon(Icons.arrow_back),
//                        onTap: Navigator.of(context).pop,
//                      )
//                    ],
//                  ),
//                ),
//            ],
//          )
          if (children != null) ...children
        ],
      ),
    );
  }
}
