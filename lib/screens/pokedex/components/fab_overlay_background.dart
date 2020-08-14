part of '../pokedex_screen.dart';

class _FabOverlayBackground extends AnimatedWidget {

  final Function onPressOut;
  Animation<double> get animation => listenable;

  _FabOverlayBackground({Animation animation, this.onPressOut})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: animation.value == 0,
      child: Container(
        color: Colors.black.withOpacity(animation.value * 0.5),
      ),
    );
  }
}
