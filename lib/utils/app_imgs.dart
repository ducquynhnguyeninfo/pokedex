import 'package:flutter/widgets.dart';

const String _imagePath = 'assets/images';

class AppImgs {
  static const bulbasaur = _Image('bulbasaur.png');
  static const charmander = _Image('charmander.png');
  static const dotted = _Image('dotted.png');
  static const female = _Image('female.png');
  static const male = _Image('male.png');
  static const pokeball = _Image('pokeball.png');
  static const squirtle = _Image('squirtle.png');
  static const thumbnail = _Image('thumbnail.png');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(dotted, context);
    await precacheImage(female, context);
    await precacheImage(male, context);
    await precacheImage(pokeball, context);
    await precacheImage(thumbnail, context);
    await precacheImage(bulbasaur, context);
    await precacheImage(charmander, context);
    await precacheImage(squirtle, context);
  }
}


class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}