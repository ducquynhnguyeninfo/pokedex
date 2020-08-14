part of '../pokedex_screen.dart';

class _PokedexAppBar extends StatelessWidget {
  final double top;
  final GlobalKey appBarKey;

  const _PokedexAppBar({Key key, this.top, this.appBarKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              padding: EdgeInsets.all(24),
              icon: Icon(Icons.arrow_back),
              onPressed: AppNavigator.pop,
            ),
          ),
          Text(
            'Pokedex',
            key: appBarKey,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Positioned(
              right: 0,
              child: IconButton(
                padding: EdgeInsets.all(24),
                icon: Icon(Icons.menu),
                onPressed: AppNavigator.pop,
              ))
        ],
      ),
    );
  }
}
