import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/utils/app_colors.dart';

class TabData {
  const TabData({this.label, this.builder});

  final Widget Function(Pokemon pokemon, Animation animation) builder;
  final String label;
}

class PokemonInfoTabContainer extends StatelessWidget {
  final Animation _animation;

  PokemonInfoTabContainer(this._animation);

  final List<TabData> _tabs = [
    TabData(
      label: 'About',
      builder: (pokemon, animation) => Container(
        alignment: Alignment.topCenter,
        child: Text('Under development'),
      ),
    ),
    TabData(
      label: 'Base Stats',
      builder: (pokemon, animation) => Container(
        alignment: Alignment.topCenter,
        child: Text('Under development'),
      ),
    ),
    TabData(
      label: 'Evolution',
      builder: (pokemon, animation) => Container(
        alignment: Alignment.topCenter,
        child: Text('Under development'),
      ),
    ),
    TabData(
      label: 'Moves',
      builder: (pokemon, animation) => Container(
        alignment: Alignment.topCenter,
        child: Text('Under development'),
      ),
    ),
  ];

  Widget _buildTabBar() {
    return TabBar(
      tabs: _tabs.map((tab) => Text(tab.label)).toList(),
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.grey,
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      indicatorColor: AppColors.indigo,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
          children: _tabs.map((tab) => tab.builder(null, _animation)).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: _tabs.length,
        initialIndex: 0,
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedBuilder(
                  animation: _animation,
                  builder: (context, _) {
                    var h = (1 - _animation.value) * 16 + 6;

                    print(h);

                    return SizedBox(height: h,);
                  }),
              _buildTabBar(),
              _buildTabContent()
            ],
          ),
        ));
  }
}
