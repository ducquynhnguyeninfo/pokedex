import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedFade extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const AnimatedFade({
    Key key,
    @required this.child,
    @required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) => IgnorePointer(
        ignoring: animation.value < 1,
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      ),
    );
  }
}
