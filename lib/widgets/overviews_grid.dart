import 'package:flutter/material.dart';
import 'package:pakai_mart/widgets/woman_overview_item.dart';
import 'package:provider/provider.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';

class OverviewsGrid extends StatelessWidget {
  final nameCategory;
  OverviewsGrid(this.nameCategory);

  @override
  Widget build(BuildContext context) {
    final overviews = Provider.of<WomanOverviews>(context)
        .womanOverviews
        .where((ov) => ov.category == nameCategory)
        .toList();
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: overviews.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => WomanOverviewItem(
        overviews[i].id,
        overviews[i].image,
        overviews[i].price,
      ),
    );
  }
}
