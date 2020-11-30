import 'package:flutter/material.dart';
import 'package:pakai_mart/models/woman_category.dart';

class WomanCategories with ChangeNotifier {
  // Properties :

  // Universal ( To All Authenticated User )
  List<WomanCategory> _womanCategories = [
    WomanCategory('upper', 'assets/images/hoodie.png', 'Hoodie'),
    WomanCategory('upper', 'assets/images/blouse.png', 'Blouse'),
    WomanCategory('upper', 'assets/images/cardigan.png', 'Cardigan'),
    WomanCategory('upper', 'assets/images/blazer.png', 'Blazer'),
    WomanCategory('upper', 'assets/images/bolero.png', 'Bolero'),
    WomanCategory('upper', 'assets/images/t-shirt.png', 'Kaos'),
    WomanCategory('upper', 'assets/images/shirt.png', 'Kemeja'),
    WomanCategory('upper', 'assets/images/sweater.png', 'Sweater'),
    WomanCategory('upper', 'assets/images/tanktop.png', 'Tank Top'),
    WomanCategory('upper', 'assets/images/vest.png', 'Vest'),
    WomanCategory(
      'upper+bottom',
      'assets/images/dress.png',
      'Dress',
    ),
    WomanCategory(
      'upper+bottom',
      'assets/images/jumpsuit.png',
      'Jumpsuit',
    ),
    WomanCategory(
      'upper+bottom',
      'assets/images/overalls.png',
      'Overalls',
    ),
    WomanCategory(
      'upper+bottom',
      'assets/images/pajamas.png',
      'Piama',
    ),
    // WomanCategory(
    //   'upper+bottom',
    //   'assets/images/minimalist-mens-fashion.png',
    //   'Catsuit',
    // ),
    // WomanCategory(
    //   'upper+bottom',
    //   'assets/images/minimalist-mens-fashion.png',
    //   'Gamis',
    // ),
    WomanCategory(
      'upper+bottom',
      'assets/images/gown.png',
      'Gaun',
    ),
  ];

  // Spesific ( To Spesific Authenticated User )

  // Setter and Getter :
  List<WomanCategory> get womanCategories {
    return [..._womanCategories];
  }

  // Method :
  List<WomanCategory> findByCategory(String category) {
    return _womanCategories.where((cat) => category == cat.category).toList();
  }
}
