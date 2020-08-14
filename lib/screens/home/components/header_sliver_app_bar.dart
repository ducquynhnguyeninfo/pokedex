part of 'package:pokedex/screens/home/home_screen.dart';

class _HeaderSliverAppBar extends StatelessWidget {
  static var heightFraction = 0.7;

  final double height;
  final bool showTitle;

  const _HeaderSliverAppBar({@required this.height, @required this.showTitle});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: height,
      floating: true,
      pinned: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        title: showTitle
            ? Text(
                "Pokédex",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : null,
        background: _buildCard(context),
      ),
    );
  }

  _buildCard(BuildContext context) {

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      child: PokeballBackground(
        childrenBuilder: (properties) => [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 117,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text("What pokémon\nare you looking for?",
                    style: TextStyle(
                        fontSize: 30,
//                        height: 0.9,
                        fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 42),
                child: SearchBar(),
              ),
              CategoryList()
            ],
          )
        ],
      ),
    );
  }
}
