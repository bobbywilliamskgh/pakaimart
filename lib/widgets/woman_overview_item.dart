import 'package:flutter/material.dart';
import 'package:pakai_mart/screens/clothes_screen/detail_screen.dart';

class WomanOverviewItem extends StatelessWidget {
  final id;
  final image;
  final price;

  WomanOverviewItem(this.id, this.image, this.price);

  void selectedOverview(ctx) {
    //final auth = Provider.of<Auth>(ctx, listen: false);
    // womanOverviews.calculateQuantityById(id, auth.userId, auth.token);
    Navigator.of(ctx).pushNamed(DetailScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectedOverview(context),
      child: GridTile(
        child: Image.asset(image),
        footer: GridTileBar(
          title: Text(
            'Rp$price',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow[300],
        ),
      ),
    );
  }
}
