import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/screens/pokemon_info/components/overall_info.dart';
import 'package:pokedex/screens/pokemon_info/components/pokemon_info_tab_container.dart';
import 'package:pokedex/utils/app_colors.dart';
import 'package:pokedex/utils/app_imgs.dart';
import 'package:pokedex/widgets/animated_rotation.dart';
import 'package:pokedex/widgets/decoration_box.dart';
import 'package:pokedex/widgets/poke_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfoScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonInfoScreen({this.pokemon});

  @override
  State<StatefulWidget> createState() {
    return _PokemonInfoScreenState();
  }
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen>
    with TickerProviderStateMixin {
  static const double _pokemonSliderOverflow = 40;

  final GlobalKey _pokemonInfoKey = GlobalKey();
  final GlobalKey _rightCornerPokeKey = GlobalKey();

  AnimationController _cardController;
  AnimationController _cardHeightController;
  AnimationController _rotateController;
  double _cardMinHeight = 0.0;
  double _cardMaxHeight = 0.0;

  @override
  void initState() {
    _cardController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _cardHeightController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 220),
    );
    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    _rotateController.repeat();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final screenHeight = MediaQuery.of(context).size.height;

      final RenderBox infoBox =
          _pokemonInfoKey.currentContext.findRenderObject();

      final appBarHeight = PokeAppBar().preferredSize.height;
      _cardMinHeight = screenHeight - infoBox.size.height;
      _cardMaxHeight =
          screenHeight - appBarHeight - MediaQuery.of(context).padding.top;
      _cardHeightController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _cardHeightController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final pokeSize = screenWidth * 0.448;

    final pokeTop = -(pokeSize / 2 -
        (IconTheme.of(context).size / 2 + AppBar().preferredSize.height));
    final pokeRight = -(pokeSize / 2 - (IconTheme.of(context).size / 2 + 28));

    return Stack(
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          constraints: BoxConstraints.expand(),
          color: AppColors.teal,
        ),
        Positioned(
          top: -screenHeight * 0.055,
          left: -screenHeight * 0.055,
          child: DecorationBox(),
        ),
        Positioned(
          top: 4,
          left: screenHeight * 0.3,
          // will need animation
          child: Image(
            image: AppImgs.dotted,
            width: screenHeight * 0.07,
            height: screenHeight * 0.07 * 0.54,
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        Positioned(
          top: pokeTop,
          right: pokeRight,
//          child: AnimatedRotation(
          child: Image(
            // a place holder
            key: _rightCornerPokeKey,
            image: AppImgs.pokeball,
            width: pokeSize,
            height: pokeSize,
            color: Colors.transparent,
          ),
//              animation: _rotateController,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: _cardHeightController, // contrller for ?
                child: PokemonInfoTabContainer(_cardController),
                builder: (context, child) {
                  return SlidingUpPanel(
                    minHeight: _cardMinHeight * _cardHeightController.value +
                        _pokemonSliderOverflow,
                    maxHeight: _cardMaxHeight,
                    boxShadow: [],
                    color: Colors.transparent,
                    panel: child,
                    onPanelSlide: (position) =>
                        _cardController.value = position,
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  key: _pokemonInfoKey,
                  // color: Colors.amber,
                  child: OverallInfo(
                      widget.pokemon, _cardController, _rotateController,
                      cornerPokeKey: _rightCornerPokeKey),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
