import 'package:flutter/material.dart';
import 'package:pokedex/utils/app_colors.dart';
import 'package:pokedex/utils/app_imgs.dart';

class PokeBackgroundProperties {
  static const double _sizeFraction = 0.66;
  static const double _topFraction = 0.154;
  static const double _rightFraction = 0.23;

  PokeBackgroundProperties._({this.size, this.top, this.right});

  final double size;
  final double top;
  final double right;

  factory PokeBackgroundProperties(Size screenSize) {
    final size = screenSize.width * _sizeFraction;
    final top = -screenSize.width * _topFraction;
    final right = -screenSize.width * _rightFraction;

    return PokeBackgroundProperties._(size: size, top: top, right: right);
  }
}

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({this.childrenBuilder, Key key}) : super(key: key);

  final List<Widget> Function(PokeBackgroundProperties) childrenBuilder;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final properties = PokeBackgroundProperties(screenSize);
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: properties.top,
            right: properties.right,
            child: Image(
              image: AppImgs.pokeball,
              width: properties.size,
              height: properties.size,
              color: AppColors.black.withOpacity(0.05),
            ),
          ),
          ...childrenBuilder(properties)
        ],
      ),
    );
  }
}
