import 'package:flutter/material.dart';
import 'package:pakai_mart/widgets/categories_grid.dart';

class WomanCategoryScreen extends StatelessWidget {
  static const routeName = '/WomanCategory';

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.yellow[200],
          ),
          Container(
            padding: EdgeInsets.only(top: 32.0),
            child: CategoriesGrid(category),
          ),
        ],
      ),
    );
  }
}
