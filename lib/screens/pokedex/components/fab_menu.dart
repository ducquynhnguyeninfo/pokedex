part of '../pokedex_screen.dart';

class _FabMenu extends StatelessWidget {
  const _FabMenu({
    @required this.animation,
    @required this.toggle,
    this.onAllGenPress,
    this.onAllTypePress,
    this.onFavouritePress,
    this.onSearchPress,
  });

  final Animation animation;
  final Function onAllGenPress;
  final Function onAllTypePress;
  final Function onFavouritePress;
  final Function onSearchPress;
  final Function toggle;

  void onPress(Function callback) {
    toggle();
    if (callback != null) callback();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedAnimationFab(
      animation: animation,
      onPress: toggle,
      items: [
        FabItem('Favourite Pokemon', Icons.favorite,
            onPress: () => onPress(onFavouritePress)),
        FabItem('All types', Icons.all_inclusive,
            onPress: () => onPress(onAllTypePress)),
        FabItem('All Generations', Icons.category,
            onPress: () => onPress(onAllGenPress)),
        FabItem('Search', Icons.search,
            onPress: () => onPress(onSearchPress)),
      ],
    );
  }
}
