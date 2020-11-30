import 'package:flutter/material.dart';
import 'package:pakai_mart/screens/clothes_screen/woman_overview_screen.dart';

class WomanCategoryItem extends StatelessWidget {
  final String image;
  final String name;

  WomanCategoryItem(this.image, this.name);

  void selectedCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(WomanOverviewScreen.routeName, arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectedCategory(context),
      child: Column(
        children: <Widget>[
          Container(
            //color: Colors.blue,
            height: 150,
            child: Image.asset(image),
          ),
          Container(
            child: Text(name),
          ),
        ],
      ),
    );
  }
}
