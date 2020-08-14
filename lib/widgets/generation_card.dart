import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/domain/entities/generation.dart';
import 'package:pokedex/utils/app_colors.dart';
import 'package:pokedex/utils/app_imgs.dart';

class GenerationCard extends StatelessWidget {
  final Generation generation;

  const GenerationCard(this.generation, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 15,
                    color: AppColors.black.withOpacity(0.12)),
              ]),
          child: Stack(
            children: [
              Positioned(
                  bottom: - height * 0.136,
                  right: - height * 0.036,
                  child: Image(
                    image: AppImgs.pokeball,
                    width: height * 0.754,
                    height: height * 0.754,
                    color: AppColors.black.withOpacity(0.05),
                  )
              ),
              Container(
                constraints: BoxConstraints.expand(),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(generation.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: generation.pokemons
                          .map((e) => Image.asset(
                                e,
                                fit: BoxFit.contain,
                                width: height * 0.41,
                                height: height * 0.41,
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
              
            ],
          ),
        );
      },
    );
  }
}
