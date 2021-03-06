part of '../home_screen.dart';

class _PokemonNewsFeed extends StatelessWidget {
  _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 28, right: 28, top: 0, bottom: 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pokémon News',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'View All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.indigo,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _buildHeader(),
        ListView.separated(
            shrinkWrap: true,
            itemCount: 9,
            separatorBuilder: (context, index) => Divider(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PokeNews(
                title: 'Pokémon Rumble Rush Arrives Soon',
                time: '15 May 2019',
                thumbnail: AppImgs.thumbnail,
              );
            },
        )
      ],
    );
  }
}
