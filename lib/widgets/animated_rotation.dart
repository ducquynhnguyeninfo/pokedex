import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedRotation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const AnimatedRotation({
    Key key,
    @required this.child,
    @required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) => Transform.rotate(
        angle: animation.value * pi * 2,
        child: child,
      ),
    );
  }
}
