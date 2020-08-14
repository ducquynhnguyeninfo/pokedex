import 'package:flutter/material.dart';
import 'package:pokedex/core/extensions/build_context.dart';

class AnimatedSlide extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const AnimatedSlide({
    Key key,
    @required this.child,
    @required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenSize.width;
    final slideWidth = screenWidth * 0.3;

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) => Transform.translate(
        offset: Offset(slideWidth * (1 - animation.value), 0),
        child: child,
      ),
    );
  }
}
