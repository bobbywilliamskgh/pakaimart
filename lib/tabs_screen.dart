import 'package:flutter/material.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/shopping_bag_screen/shopping_bag_screen.dart';
import 'screens/clothes_screen/gender_category_screen.dart';
import 'screens/casheer_screen/casheer_screen.dart';
import 'screens/account_screen/account_screen.dart';
import './my_flutter_app_icons.dart';

class TabsScreen extends StatefulWidget {
  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  var selectedPageIndex = 0;

  void selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(),
      ShoppingBagScreen(selectedPage),
      GenderCategoryScreen(),
      CasheerScreen(),
      AccountScreen(),
    ];

    return Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellowAccent,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.shopping_basket),
            title: Text('Tas Belanjaan'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(MyFlutterApp.clothes), // Akan diganti logo pakaian
            title: Text('Pakaian'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.local_atm),
            title: Text('Kasir'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            title: Text('Akun'),
          ),
        ],
      ),
    );
  }
}
