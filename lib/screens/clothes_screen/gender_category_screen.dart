/*
import 'package:flutter/material.dart';
import '../models/shirts.dart';

class ClothesScreen extends StatefulWidget {
  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  List<Shirts> listOfShirts = [
    Shirts(
      name: 'Blouse Crop',
      price: '2.000',
      material: '',
      size: ['S', 'M', 'L'],
      color: ['Pink', 'Black'],
    ),
    Shirts(
      name: 'C',
      price: '1.000',
      material: 'blouse',
      size: ['S', 'M'],
      color: ['Yellow', 'Red'],
    ),
    Shirts(
      name: 'D',
      price: '3.000',
      material: 'blouse',
      size: ['S', 'M'],
      color: ['Green', 'Red'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Text(
                  'Baju',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: listOfShirts.map((shirt) {
                    return Column(
                      children: <Widget>[
                        Text(
                          shirt.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          shirt.price,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Text(
                  'Jaket',
                  style: TextStyle(color: Colors.white),
                ),
                Row(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Text(
                  'Celana',
                  style: TextStyle(color: Colors.white),
                ),
                Row(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Text(
                  'Topi',
                  style: TextStyle(color: Colors.white),
                ),
                Row(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Text(
                  'Pakaian Dalam',
                  style: TextStyle(color: Colors.white),
                ),
                Row(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:pakai_mart/screens/clothes_screen/luar_dalam_screen.dart';

class GenderCategoryScreen extends StatelessWidget {
  void selectedWomanButton(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(LuarDalamScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Male
        Expanded(
          // Coming Soon
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Color.fromRGBO(255, 255, 255, 0.4),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    image: const DecorationImage(
                      image: const AssetImage('assets/images/male.webp'),
                    ),
                  ),
                ),
              ),
              Container(
                color: const Color.fromRGBO(255, 255, 255, 0.4),
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
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Female
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.yellow,
              ),
              GestureDetector(
                onTap: () => selectedWomanButton(context),
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/female.png'),
                  //color: Colors.yellow,
                  //child: Text('Wanita'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
