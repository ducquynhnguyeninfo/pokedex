import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/routes.dart';
import 'package:pokedex/screens/pokedex/components/modals/generation_modal.dart';
import 'package:pokedex/screens/pokedex/components/modals/search_bottom_modal.dart';
import 'package:pokedex/widgets/fab.dart';
import 'package:pokedex/widgets/pokeball_background.dart';
import 'package:pokedex/core/extensions/animation.dart';

part 'components/pokedex_app_bar.dart';
part 'components/fab_menu.dart';
part 'components/pokemon_gird.dart';
part 'components/fab_overlay_background.dart';

class PokedexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PokedexScreenState();
  }
}

class _PokedexScreenState extends State<PokedexScreen>
    with SingleTickerProviderStateMixin {

  static const double _endReachedThreshold = 200;

  final ScrollController _scrollController = ScrollController();

  Animation<double> _fabAnimation;
  AnimationController _fabController;
  bool _isFabMenuVisible = false;

  @override
  void initState() {
    _fabController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));

    _fabAnimation = _fabController.curvedTweenAnimation(begin: 0.0, end: 1.0);

    _scrollController.addListener(_onScroll);
    scheduleMicrotask(() {
      // get data the first time
    });
    super.initState();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final thresholdReached = _scrollController.position.extentAfter < _endReachedThreshold;
//    final isLoading = p

  }

  _toggleFabMenu() {
    if (_isFabMenuVisible) {
      _fabController.reverse();
    } else {
      _fabController.forward();
    }
    _isFabMenuVisible = !_isFabMenuVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PokeballBackground(
        childrenBuilder: (props) {
          final appBarTop =
              props.size / 2 + props.top - IconTheme.of(context).size / 2;

          return [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PokedexAppBar(
                  top: appBarTop
                ),
                _buildTitle(),
                _buildPokemonGrid(),
              ],
            ), _FabOverlayBackground(
              animation: _fabAnimation,
              onPressOut: _toggleFabMenu,
            ),
          ];
        },
      ),
      floatingActionButton: _FabMenu(
        animation: _fabAnimation,
        toggle: _toggleFabMenu,
        onAllGenPress: _showGenerationModal,
        onAllTypePress: _showSearchModal,
      ),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => GenerationModal());
  }

  void _showSearchModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) => SearchBottomModal());
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 18, left: 26, right: 26, bottom: 4),
      child: Text(
        'Pokédex',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPokemonGrid() {
    return Expanded(
      child: _PokemonGrid(
        pokemons: [],
        canLoadMore: true,
          controller: _scrollController,
        onRefresh: _onRefresh,
        onSelectPokemon: (index, pokemon) {
          AppNavigator.push(Routes.pokemonInfo, pokemon);
        },
      ),
    );
  }

  Future _onRefresh() async {

  }
}
