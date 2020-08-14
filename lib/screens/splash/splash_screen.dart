import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/routes.dart';
import 'package:pokedex/utils/app_imgs.dart';
import 'package:pokedex/widgets/pokeball_background.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    scheduleMicrotask(() async {
      await AppImgs.precacheAssets(context);
      await AppNavigator.replacedWith(Routes.home);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PokeballBackground(
          childrenBuilder: (_) =>  [
            Text("Pokedex")
          ],
        ),
      ),
    );
  }
}