import 'package:flutter/cupertino.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (BuildContext buildContext, Animation animation, Animation secondAnimation) => page,
          transitionsBuilder: (BuildContext buildContext, Animation animation, Animation secondAnimation, child) => FadeTransition(
            child: child,
            opacity: animation,
          ),
        );
}
