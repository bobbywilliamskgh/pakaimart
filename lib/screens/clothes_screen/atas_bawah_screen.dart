import 'package:flutter/material.dart';
import 'package:pakai_mart/screens/clothes_screen/woman_category_screen.dart';

class AtasBawahScreen extends StatelessWidget {
  static const routeName = '/AtasBawah';

  void selectedClothesButton(BuildContext ctx, String category) {
    switch (category) {
      case 'upper':
        Navigator.of(ctx)
            .pushNamed(WomanCategoryScreen.routeName, arguments: category);
        break;
      case 'upper+bottom':
        Navigator.of(ctx)
            .pushNamed(WomanCategoryScreen.routeName, arguments: category);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
    final categoriesData = Provider.of<WomanCategories>(context);
    final categoriesUpper = categoriesData.loadedCategoryUpper;
    final categoriesUpperPlusBottom =
        categoriesData.loadedCategoryUpperPlusBottom;
  */

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => selectedClothesButton(context, 'upper'),
                    child: Container(
                      height: 100.0,
                      child: Image.asset('assets/images/upper_clothes2.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Atas'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => selectedClothesButton(context, 'upper+bottom'),
                    child: Container(
                      height: 150.0,
                      child: Image.asset('assets/images/upper_and_bottom.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Atas + Bawah'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.yellow[300],
                ),
                Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Image.asset(
                              'assets/images/bottom_clothes.png'), // Coming Soon
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text('Dalam'),
                  ],
                ),
                Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: const Text(
                      'COMING SOON',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'bold',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
