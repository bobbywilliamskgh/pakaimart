import 'package:flutter/material.dart';
import 'package:pakai_mart/screens/clothes_screen/atas_bawah_screen.dart';

class LuarDalamScreen extends StatelessWidget {
  static const routeName = '/LuarDalam';

  void selectedLuarButton(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(AtasBawahScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.yellow[100],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => selectedLuarButton(context),
                        child: Container(
                          height: 100,
                          child:
                              Image.asset('assets/images/outter_clothes.png'),
                          //color: Colors.blue,
                          //child: Text('Luar'),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text('Luar'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
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
                    const Text('Dalam'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 100.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Image.asset(
                              'assets/images/underwear.png'), // Coming Soon
                        ),
                      ),
                    ),
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
