import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/utils/app_colors.dart';

class FabItem {
  const FabItem(this.title, this.icon, {this.onPress});

  final IconData icon;
  final Function onPress;
  final String title;
}

class FabMenuItem extends StatelessWidget {
  final FabItem item;

  FabMenuItem(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: StadiumBorder(),
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 16),
      color: Colors.white,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 0,
      highlightElevation: 2,
      disabledColor: Colors.white,
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.title),
          SizedBox(
            width: 8,
          ),
          Icon(
            item.icon,
            color: AppColors.indigo,
          )
        ],
      ),
    );
  }
}

class ExpandedAnimationFab extends AnimatedWidget {
  const ExpandedAnimationFab(
      {@required this.items, this.onPress, Animation animation})
      : super(listenable: animation);

  final List<FabItem> items;
  final Function onPress;

  Animation<double> get _animation => listenable;

  Widget _itemBuilder(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final diagonal =
        sqrt(screenWidth * screenWidth + screenHeight * screenHeight);

    final transform = Matrix4.translationValues(
        -(screenWidth - _animation.value * screenWidth) *
            ((items.length - index) / items.length),
        -(screenHeight - _animation.value * screenHeight) *
            ((items.length - index) / items.length),
        0.0);

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: FabMenuItem(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: _animation.value == 0,
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: _itemBuilder,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemCount: items.length),
        ),
        FloatingActionButton(
          backgroundColor: AppColors.blue,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animation,
          ),
          onPressed: onPress,
        )
      ],
    );
  }
}
