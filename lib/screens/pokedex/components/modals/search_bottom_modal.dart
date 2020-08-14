import 'package:flutter/widgets.dart';
import 'package:pokedex/widgets/modal.dart';
import 'package:pokedex/widgets/search_bar.dart';

class SearchBottomModal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom + 14;

    return Modal(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            child: SearchBar(margin: EdgeInsets.symmetric(horizontal: 2, vertical: 14),),
          ),
          SizedBox(height: viewInsets,)
        ],
      ),
    );
  }

}