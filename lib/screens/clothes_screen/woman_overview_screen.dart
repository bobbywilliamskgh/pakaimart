import 'package:flutter/material.dart';
import 'package:pakai_mart/widgets/overviews_grid.dart';

class WomanOverviewScreen extends StatelessWidget {
  static const routeName = '/OverviewScreen';

  @override
  Widget build(BuildContext context) {
    final nameCategory = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(nameCategory),
        backgroundColor: Colors.yellow,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.yellow[200],
          ),
          OverviewsGrid(nameCategory),
        ],
      ),
    );
  }
}
