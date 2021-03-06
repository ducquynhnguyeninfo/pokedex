part of '../pokedex_screen.dart';

class _PokemonGrid extends StatelessWidget {
  final ScrollController controller;
  final List<Pokemon> pokemons;
  final bool canLoadMore;
  final Future Function() onRefresh;
  final Function(int, Pokemon) onSelectPokemon;

  _PokemonGrid(
      {Key key,
      @required this.controller,
      @required this.pokemons,
      @required this.canLoadMore,
      @required this.onRefresh,
      @required this.onSelectPokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomOffset = MediaQuery.of(context).padding.bottom;
    final paddingBottom = max(bottomOffset, 28.0);

    return CustomScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
        ),
        SliverPadding(
          padding: EdgeInsets.all(28),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(),
                childCount: pokemons?.length ?? 0),
          ),
        ),
        SliverToBoxAdapter(
          child: canLoadMore
              ? Container(
//          padding: EdgeInsets.only(bottom: paddingBottom),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        )
      ],
    );
  }
}
