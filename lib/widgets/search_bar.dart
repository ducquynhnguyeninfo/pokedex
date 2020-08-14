import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/utils/app_colors.dart';

class SearchBar extends StatelessWidget {
  final EdgeInsets margin;

  SearchBar(
      {Key key, this.margin = const EdgeInsets.symmetric(horizontal: 28)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      margin: margin,
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search),
          SizedBox(
            width: 13,
          ),
          Expanded(
              child: TextFormField(
            decoration: InputDecoration(
                hintText: "Search Pokemon, Move, Abilities, etc...",
                hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
                border: InputBorder.none),
          ))
        ],
      ),
    );
  }
}
