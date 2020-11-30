import 'package:flutter/material.dart';
import 'package:pakai_mart/providers/woman_categories.dart';
import 'package:provider/provider.dart';
import 'woman_category_item.dart';

class CategoriesGrid extends StatelessWidget {
  final category;
  CategoriesGrid(this.category);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<WomanCategories>(context, listen: false)
        .findByCategory(category);
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => WomanCategoryItem(
        categories[i].image,
        categories[i].name,
      ),
    );
  }
}
