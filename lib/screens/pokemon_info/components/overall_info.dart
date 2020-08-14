import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/entities/pokemon_types.dart';
import 'package:pokedex/utils/app_imgs.dart';
import 'package:pokedex/utils/durations.dart';
import 'package:pokedex/widgets/animated_fade.dart';
import 'package:pokedex/widgets/animated_rotation.dart';
import 'package:pokedex/widgets/animated_slide.dart';
import 'package:pokedex/widgets/poke_app_bar.dart';
import 'package:pokedex/widgets/pokemon_type.dart';

class OverallInfo extends StatefulWidget {
  final Pokemon pokemon;
  final AnimationController transitionController;
  final AnimationController rotateController;
  final GlobalKey cornerPokeKey;

  const OverallInfo(
      this.pokemon, this.transitionController, this.rotateController,
      {this.cornerPokeKey});

  @override
  State<StatefulWidget> createState() {
    return OverallInfoState();
  }
}

class DistanceDIff {
  final dx;
  final dy;

  DistanceDIff(@required this.dx, @required this.dy);

  @override
  String toString() {
    return 'DistanceDIff{dx: $dx, dy: $dy}';
  }
}

class OverallInfoState extends State<OverallInfo>
    with TickerProviderStateMixin {
  static const double _pokemonSliverViewportFraction = 0.6;
  static const int _endReachedThreshold = 4;

  // key would help to get the attribute of widget once it get rendered
  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();

  AnimationController _slideController;
  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;

  Pokemon get pokemon => widget.pokemon;

  AnimationController get transitionController => widget.transitionController;

  AnimationController get rotationController => widget.rotateController;

  GlobalKey get cornerPokeKey => widget.cornerPokeKey;
  final GlobalKey _centerPokeKey = GlobalKey();

  DistanceDIff ballDiff;

  @override
  void initState() {
    _slideController =
        AnimationController(vsync: this, duration: animationDuration);
    _slideController.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // locating the location of the text currently rendered
      final RenderBox targetTextBox =
          _targetTextKey.currentContext.findRenderObject();
      final targetTextPosition = targetTextBox.localToGlobal(Offset.zero);

      // locating the location of the text currently rendered
      final RenderBox currentTextBox =
          _currentTextKey.currentContext.findRenderObject();
      final currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

      textDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      textDiffTop = targetTextPosition.dy - currentTextPosition.dy;

      // calculate distance of poke balls
      final RenderBox topRightBallBox =
          cornerPokeKey.currentContext.findRenderObject();
      final cornerBallPosition = topRightBallBox.localToGlobal(Offset.zero);

      final RenderBox centerBallBox =
          _centerPokeKey.currentContext.findRenderObject();
      final centerBallPosition = centerBallBox.localToGlobal(Offset.zero);

      ballDiff = new DistanceDIff(centerBallPosition.dx - cornerBallPosition.dx,
          centerBallPosition.dy - cornerBallPosition.dy);

      print("initState ${ballDiff.toString()}");
    });

    super.initState();
  }

  @override
  void dispose() {
    _slideController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PokeAppBar(
          // indeed a place holder
          title: Text(
            pokemon?.name ?? "Pokemon's name at top",
            key: _targetTextKey,
            style: TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.w900,
                fontSize: 22),
          ),
          rightButton: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 9),
        _buildPokemonName(),
        SizedBox(height: 9),
        _buildPokemonTypes(),
        SizedBox(height: 9),
        _buildPokemonSlider(),
      ],
    );
  }

  Widget _buildPokemonName() {
    final fadeAnimation =
        Tween(begin: 1.0, end: 0.0).animate(transitionController);
    final pokemonNum = pokemon?.number ?? "#002";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          AnimatedBuilder(
            animation: transitionController,
            builder: (context, child) {
              final value = transitionController.value ?? 0.0;
              final pokemonName = pokemon?.name ?? "Pokemon's name";

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: Hero(
                  //  do we really need Hero?
                  tag: pokemonName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      pokemonName,
                      key: _currentTextKey,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 36 - (36 - 22) * value),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedSlide(
            animation: _slideController,
            child: AnimatedFade(
                animation: fadeAnimation,
                child: Hero(
                  tag: pokemonNum,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      pokemonNum,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildPokemonTypes() {
    final fadeAnimation =
        Tween(begin: 1.0, end: 0.0).animate(transitionController);

    return AnimatedFade(
      animation: fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: pokemon?.types
                      ?.map((PokemonTypes type) => Hero(
                            tag: type,
                            child: Text(type.value.toString()),
                          ))
                      ?.toList() ??
                  [
                    Hero(
                      tag: "grass",
                      child: PokemonType(
                        "grass".toString(),
                        large: true,
                      ),
                    ),
                    Hero(
                      tag: "fly",
                      child: PokemonType("fly".toString(), large: true),
                    ),
                  ],
            ),
            Text(
              "Lizard",
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonSlider() {
    final screenSize = MediaQuery.of(context).size;
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: transitionController,
        curve: Interval(0.0, 0.5, curve: Curves.ease)));

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.24,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: transitionController,
              builder: (context, child) {
                var value = transitionController.value ?? 0.0;
                var dx = 0.0;
                var dy = 0.0;
                print("transitionController ${transitionController.value}");
                print("opacity: ${0.26 - ((0.26 - 0.14) * (1 - transitionController.value))}");

                var widget = AnimatedRotation(
                    animation: rotationController,
                    child: Image(
                      key: _centerPokeKey,
                      image: AppImgs.pokeball,
                      width: screenSize.height * 0.24,
                      height: screenSize.height * 0.24,
                      color: Colors.white.withOpacity(0.26 - ((0.26 - 0.14) * (1 - value))), // min 0.14 max 0.26
                    ));

                if (ballDiff != null) {
                  dx = ballDiff.dx * value;
                  dy = ballDiff.dy * value;
                  return Transform.translate(
                      offset: Offset(-dx, -dy), child: widget);
                } else {
                  return widget;
                }
              },
//              child: AnimatedRotation(
//                animation: rotationController,
//                child: Image(
//                  key: _centerPokeKey,
//                  image: AppImgs.pokeball,
//                  width: screenSize.height * 0.24,
//                  height: screenSize.height * 0.24,
//                  color: transitionController.value == 1 ? Colors.transparent : Colors.white.withOpacity(0.14),
////                  color: Colors.white.withOpacity(0.26 - ((0.26 - 0.14) * (1 - transitionController.value))), // min 0.14 max 0.26
//                ),
//              ),
            ),
          ),
          AnimatedFade(
            animation: fadeAnimation,
            child: PageView.builder(
              itemBuilder: (context, index) => Hero(
                tag: "image",
                child: AnimatedPadding(
                  duration: Duration(seconds: 600),
                  curve: Curves.easeOutQuint,
                  padding: EdgeInsets.only(
                      top: screenSize.height * 0,
                      bottom: screenSize.height * 0),
                  child: Image.network(
                    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/003.png",
                    width: screenSize.height * 0.28,
                    height: screenSize.height * 0.28,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
