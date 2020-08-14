import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/utils/app_colors.dart';
import 'package:pokedex/utils/app_imgs.dart';
import 'package:pokedex/widgets/category_list.dart';
import 'package:pokedex/widgets/poke_news.dart';
import 'package:pokedex/widgets/pokeball_background.dart';
import 'package:pokedex/widgets/search_bar.dart';
import 'package:pokedex/core/extensions/build_context.dart';

part 'package:pokedex/screens/home/components/header_sliver_app_bar.dart';
part 'package:pokedex/screens/home/components/pokemon_news.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  double appbarHeight = 0;
  bool showTitle = false;

  ScrollController _scrollController;

  @override
  void initState() {
    scheduleMicrotask(() {
      setState(() {
        appbarHeight =
            context.screenSize.height * _HeaderSliverAppBar.heightFraction;
      });
    });
    _scrollController = ScrollController()..addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    setState(() {
      showTitle = _scrollController.offset > appbarHeight - kToolbarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      extendBody: true,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder:
            (BuildContext buildContext, bool innerBoxIsScrolled) {
          return [
            _HeaderSliverAppBar(
              height: appbarHeight,
              showTitle: showTitle,
            )
          ];
        },
        body: _PokemonNewsFeed(),
      ),
    );
  }
}
