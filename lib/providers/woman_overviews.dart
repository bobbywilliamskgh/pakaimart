import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pakai_mart/models/woman_overview.dart';
import 'package:http/http.dart' as http;

class WomanOverviews with ChangeNotifier {
  // Properties :

  // Universal ( To All Authenticated User )

  List<WomanOverview> _womanOverviews = [
    WomanOverview(
      id: '1',
      code: 'AL',
      category: 'Hoodie',
      image: 'assets/images/1.jpg',
      price: 75000,
      size: 'All size fit to L',
      substance: 'Fleece',
    ),
    WomanOverview(
      id: '2',
      code: 'AL',
      category: '', // CATEGORY ?
      image: 'assets/images/2.jpg',
      price: 80000,
      size: 'All size fit to L',
      substance: 'Despo',
    ),
    WomanOverview(
      id: '3',
      code: 'AL',
      category: 'Hoodie',
      image: 'assets/images/3.jpg',
      price: 70000,
      size: 'All size fit to L',
      substance: 'Fleece',
    ),
    WomanOverview(
      id: '4',
      code: 'GF',
      category: 'Blouse',
      image: 'assets/images/4.jpg',
      price: 0, // PRICE ?
      size: 'LD 102',
      substance: 'Despo',
    ),
    // WomanOverview( GAK JADI !
    //   id: '5',
    //   code: '',
    //   category: 'Piama',
    //   image: 'assets/images/5.jpg',
    //   price: 0,
    //   size: '',
    //   substance: '',
    // ),
    WomanOverview(
      id: '5',
      code: 'ACB',
      category: 'Dress',
      image: 'assets/images/5.jpg',
      price: 75000,
      size: 'LD 100, PJ 88',
      substance: 'Twiscone tebal',
    ),
    WomanOverview(
      id: '6',
      code: 'ACB',
      category: 'Dress',
      image: 'assets/images/6.jpg',
      price: 85000,
      size: 'LD 120, PJ 92',
      substance: 'Moscrepe',
    ),
    WomanOverview(
      id: '7',
      code: 'ACB',
      category: 'Dress',
      image: 'assets/images/7.jpg',
      price: 70000,
      size: 'LD 90, PJ 91',
      substance: 'Twiscone',
    ),
    WomanOverview(
      id: '8',
      code: 'ACB',
      category: 'Dress',
      image: 'assets/images/8.jpg',
      price: 76000,
      size: 'LD 98, PJ 110',
      substance: 'Twisonce tebal',
    ),
    WomanOverview(
      id: '9',
      code: 'ACB',
      category: 'Dress',
      image: 'assets/images/9.jpg',
      price: 86000,
      size: 'LD 120, PJ 94',
      substance: 'Moscrepe',
    ),
    WomanOverview(
      id: '10',
      code: 'ACB',
      category: 'Jumpsuit',
      image: 'assets/images/10.jpg',
      price: 70000,
      size: 'Fit to L',
      substance: 'Moscrepe',
    ),
    WomanOverview(
      id: '11',
      code: 'ACB',
      category: 'Overalls',
      image: 'assets/images/11.jpg',
      price: 65000,
      size: 'Fit to L',
      substance: 'Moscrepe',
    ),
    WomanOverview(
      id: '12',
      code: 'ACB',
      category: 'Cardigan',
      image: 'assets/images/12.jpg',
      price: 55000,
      size: 'All size',
      substance: 'Moscrepe',
    ),
  ];

  // Spesific ( To Spesific Authenticated User per UserId )

  List<WomanOverview> _setOfClothes;

  List<int> _totalPerId;

  int _totalPayment;

  int _totalItems;

  bool _firstPayment;

  bool _isFinishPayment;

  int _amountOfShoppingBag;

  int _quantityById;

  List<WomanOverview> _buys;

  // Setter and Getter :

  // Universal
  List<WomanOverview> get womanOverviews {
    return [..._womanOverviews];
  }

  // Spesific

  List<WomanOverview> get setOfClothes {
    return [..._setOfClothes];
  }

  List<int> get totalPerId {
    return [..._totalPerId];
  }

  int get totalPayment {
    return _totalPayment;
  }

  int get totalItems {
    return _totalItems;
  }

  bool get firstPayment {
    return _firstPayment;
  }

  bool get isFinishPayment {
    return _isFinishPayment;
  }

  int get amountInShoppingBag => _amountOfShoppingBag;

  int get quantityById => _quantityById;

  // METHOD
  Future<void> fetchAmountOfShoppingBag(String userId, String authToken) async {
    final url =
        'https://pakaimart-177c9.firebaseio.com/amountOfShoppingBag/$userId.json?auth=$authToken';
    try {
      var response = await http.get(url);
      final extractedData = json.decode(response.body);
      var amountOfShoppingBag = 0;
      if (extractedData == null) {
        response = await http.patch(url,
            body: json.encode({'amountOfShoppingBag': 0}));
        print('jika null : ${json.decode(response.body)}');
        _amountOfShoppingBag = amountOfShoppingBag;
        print('fetchAmountOfShoppingBag'); // Untuk debugging
        return;
      }
      print('jika tidak null: ${json.decode(response.body)}');
      amountOfShoppingBag = extractedData['amountOfShoppingBag'];
      print('amountOfShoppingBag dari server = $amountOfShoppingBag');
      _amountOfShoppingBag = amountOfShoppingBag; // Untuk debugging
      print('fetchAmountOfShoppingBag');
      //_amountOfShoppingBag = amountOfShoppingBag;
    } catch (error) {
      print('error in fetchAmountOfShoppingBag...');
      throw error;
    }
  }

  Future<void> fetchAndSetFirstPayment(String userId, String authToken) async {
    print('start fetchAndSetFirstPayment');
    final url =
        'https://pakaimart-177c9.firebaseio.com/firstPayment/$userId.json?auth=$authToken';
    bool firstPaymentFromServer;
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        await http.patch(url, body: json.encode({'firstPayment': false}));
        _firstPayment = false;
        return;
      }
      firstPaymentFromServer = extractedData['firstPayment'];
      _firstPayment = firstPaymentFromServer;
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetIsFinishPayment(
      String userId, String authToken) async {
    final url =
        'https://pakaimart-177c9.firebaseio.com/isFinishPayment/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      bool isFinishPaymentFromServer;
      if (extractedData == null) {
        http.patch(url,
            body:
                json.encode({'isFinishPayment': false})); // Not required await
        _isFinishPayment = false;
        return;
      }
      print('extractedData di fetchAndSetIsFinishPayment = $extractedData');
      isFinishPaymentFromServer = extractedData['isFinishPayment'];
      _isFinishPayment = isFinishPaymentFromServer;
    } catch (error) {
      print('error in fetchAndSetIsFinishPayment');
      throw error;
    }
  }

  Future<void> fetchAndSetQuantityById(
      String userId, String authToken, String id) async {
    print('fechAndSetQuantityById start...');
    final url =
        'https://pakaimart-177c9.firebaseio.com/quantityById/$userId/$id.json?auth=$authToken';
    int quantityByIdFromServer;
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    print('fetchAndSetQuantityById after start...');
    if (extractedData == null) {
      await http.patch(url, body: json.encode({'quantityById': 0}));
      _quantityById = 0;
      print('fechAndSetQuantityById finish');
      return;
    }
    quantityByIdFromServer = extractedData['quantityById'];
    print('quantityByIdFromServer = $quantityByIdFromServer');
    _quantityById = quantityByIdFromServer;
  }

  Future<void> addClothes(String id, String userId, String authToken) async {
    print('addClothes');
    print('test1');
    print('test2');
    print('test3');
    final urlBuys =
        'https://pakaimart-177c9.firebaseio.com/buys/$userId.json?auth=$authToken';
    final urlBuysAfterFirstPayment =
        'https://pakaimart-177c9.firebaseio.com/buysAfterFirstPayment/$userId.json?auth=$authToken';
    final urlFirstPayment =
        'https://pakaimart-177c9.firebaseio.com/firstPayment/$userId.json?auth=$authToken';
    final responseFirstPayment = await http.get(urlFirstPayment);
    final extractedDataFirstPayment = json.decode(responseFirstPayment.body);
    final responseBuys = await http.get(urlBuys);
    final extractedDataBuys = json.decode(responseBuys.body);
    var oneClothes = _womanOverviews.firstWhere((ov) => ov.id == id);
    List<dynamic> buysPerId = [];

    if (extractedDataBuys == null) {
      _buys = [];
      _buys.add(oneClothes);
      buysPerId.add(id);
      totalInShoppingBag(_buys.length, 'add', userId, authToken);
      http.patch(urlBuys, body: json.encode({'buysPerId': buysPerId}));
      return;
    }

    _firstPayment = extractedDataFirstPayment['firstPayment'];
    if (_firstPayment) {
      List<dynamic> buysPerIdAfterFirstPayment = [];
      final responseBuysAfterFirstPayment =
          await http.get(urlBuysAfterFirstPayment);
      final extractedDataBuysAfterFirstPayment =
          json.decode(responseBuysAfterFirstPayment.body);

      if (extractedDataBuysAfterFirstPayment == null) {
        _buys = [];
        _buys.add(oneClothes);
        buysPerIdAfterFirstPayment.add(id);
        http.patch(urlBuysAfterFirstPayment,
            body: json.encode(
                {'buysPerIdAfterFirstPayment': buysPerIdAfterFirstPayment}));
      } else {
        buysPerIdAfterFirstPayment =
            extractedDataBuysAfterFirstPayment['buysPerIdAfterFirstPayment'];
        buysPerIdAfterFirstPayment.add(id);
        http.patch(urlBuysAfterFirstPayment,
            body: json.encode(
                {'buysPerIdAfterFirstPayment': buysPerIdAfterFirstPayment}));
        _buys = [];
        buysPerIdAfterFirstPayment.forEach((id) {
          var wov = _womanOverviews.firstWhere((wov) => wov.id == id);
          _buys.add(wov);
        });
      }
      totalInShoppingBag(_buys.length, 'add', userId, authToken);
      // Update To Server
      buysPerId = extractedDataBuys['buysPerId'];
      buysPerId.add(id);
      http.patch(urlBuys, body: json.encode({'buysPerId': buysPerId}));
    } else {
      // Update To Server
      buysPerId = extractedDataBuys['buysPerId'];
      buysPerId.add(id);
      http.patch(urlBuys, body: json.encode({'buysPerId': buysPerId}));
      // Update locally
      _buys = [];
      buysPerId.forEach((id) {
        var wov = _womanOverviews.firstWhere((wov) => wov.id == id);
        _buys.add(wov);
      });
      print('buys setelah ditambah = $_buys');
      totalInShoppingBag(_buys.length, 'add', userId, authToken);
      print('List baju yang dibeli: $_buys');
    }
  }

  Future<void> removeClothes(String id, String userId, String authToken) async {
    final urlAmountOfShoppingBag =
        'https://pakaimart-177c9.firebaseio.com/amountOfShoppingBag/$userId.json?auth=$authToken';
    final urlFirstPayment =
        'https://pakaimart-177c9.firebaseio.com/firstPayment/$userId.json?auth=$authToken';
    final urlBuys =
        'https://pakaimart-177c9.firebaseio.com/buys/$userId.json?auth=$authToken';
    final urlBuysAfterFirstPayment =
        'https://pakaimart-177c9.firebaseio.com/buysAfterFirstPayment/$userId.json?auth=$authToken';
    final responseAmountOfShoppingBag = await http.get(urlAmountOfShoppingBag);
    final extractedDataAmountOfShoppingBag =
        json.decode(responseAmountOfShoppingBag.body);

    _amountOfShoppingBag =
        extractedDataAmountOfShoppingBag['amountOfShoppingBag'];
    List<dynamic> buysPerId = [];
    List<dynamic> buysPerIdAfterFirstPayment = [];
    //print('buys di awal remove = $_buys');
    //var oneClothes = _womanOverviews.firstWhere((ov) => ov.id == id);

    if (_amountOfShoppingBag > 0) {
      final responseBuys = await http.get(urlBuys);
      final responseFirstPayment = await http.get(urlFirstPayment);
      final extractedDataBuys = json.decode(responseBuys.body);
      final extractedDataFirstPayment = json.decode(responseFirstPayment.body);
      _firstPayment = extractedDataFirstPayment['firstPayment'];
      if (_firstPayment) {
        final responseBuysAfterFirstPayment =
            await http.get(urlBuysAfterFirstPayment);
        final extractedDataBuysAfterFirstPayment =
            json.decode(responseBuysAfterFirstPayment.body);

        buysPerIdAfterFirstPayment =
            extractedDataBuysAfterFirstPayment['buysPerIdAfterFirstPayment'];

        buysPerIdAfterFirstPayment.remove(id);
        totalInShoppingBag(
            buysPerIdAfterFirstPayment.length, 'remove', userId, authToken);
        // Has Removed...
        http.patch(urlBuysAfterFirstPayment,
            body: json.encode(
                {'buysPerIdAfterFirstPayment': buysPerIdAfterFirstPayment}));
        // Update locally
        _buys = [];
        if (buysPerIdAfterFirstPayment.length != 0) {
          buysPerIdAfterFirstPayment.forEach((id) {
            var wov = _womanOverviews.firstWhere((wov) => wov.id == id);
            _buys.add(wov);
          });
        }
        // GlOBALLY (SERVER)
        buysPerId = extractedDataBuys['buysPerId'];
        buysPerId.remove(id);
        http.patch(urlBuys, body: json.encode({'buysPerId': buysPerId}));
      } else {
        // GlOBALLY (SERVER)
        buysPerId = extractedDataBuys['buysPerId'];
        buysPerId.remove(id);
        http.patch(urlBuys, body: json.encode({'buysPerId': buysPerId}));

        // Update locally
        totalInShoppingBag(buysPerId.length, 'remove', userId, authToken);
        _buys = [];
        if (buysPerId.length != 0) {
          buysPerId.forEach((id) {
            var wov = _womanOverviews.firstWhere((wov) => wov.id == id);
            _buys.add(wov);
          });
        }
      }
    }
    print('_amountOfShoppingBag > 0');
    print('finish remove...');
    // print('buys setelah remove = $_buys');
  }

  Future<void> totalInShoppingBag(
      int total, String operation, String userId, String authToken) async {
    final urlAmountOfShoppingBag =
        'https://pakaimart-177c9.firebaseio.com/amountOfShoppingBag/$userId.json?auth=$authToken';
    // final urlFirstPayment =
    //     'https://pakaimart-177c9.firebaseio.com/firstPayment/$userId.json?auth=$authToken';
    // final responseFirstPayment = await http.get(urlFirstPayment);
    // final responseAmountOfShoppingBag = await http.get(urlAmountOfShoppingBag);
    // final extractedDataFirstPayment = json.decode(responseFirstPayment.body);
    // final extractedDataAmountOfShoppingBag =
    //     json.decode(responseAmountOfShoppingBag.body);
    // _firstPayment = extractedDataFirstPayment['firstPayment'];
    // _amountOfShoppingBag =
    //     extractedDataAmountOfShoppingBag['amountOfShoppingBag'];
    // if (_firstPayment) {
    //   if (operation == 'add') {
    //     await http.patch(urlAmountOfShoppingBag,
    //         body: json.encode({'amountOfShoppingBag': _amountOfShoppingBag++}));
    //   } else if (operation == 'remove') {
    //     if (_amountOfShoppingBag > 0) {
    //       await http.patch(urlAmountOfShoppingBag,
    //           body:
    //               json.encode({'amountOfShoppingBag': _amountOfShoppingBag--}));
    //     }
    //   }
    //   print('jumlah di tas = $_amountOfShoppingBag jika firsPayment true');
    // } else {
    _amountOfShoppingBag = total;
    await http.patch(urlAmountOfShoppingBag,
        body: json.encode({'amountOfShoppingBag': total}));
    //}

    print('Jumlah di tas: $_amountOfShoppingBag');
  }

  Future<void> calculateQuantityById(
      String id, String userId, String authToken) async {
    print('calculateQuantityById');
    final urlQuantityById =
        'https://pakaimart-177c9.firebaseio.com/quantityById/$userId/$id.json?auth=$authToken';
    // final urlFirstPayment =
    //     'https://pakaimart-177c9.firebaseio.com/firstPayment/$userId.json?auth=$authToken';

    if (_buys.length == 0) {
      _quantityById = 0;
      notifyListeners();
    } else {
      var listClothesBoughtById = _buys.where((ov) => ov.id == id).toList();
      print('buys where = $_buys');
      // final response = await http.get(urlFirstPayment);
      // final extractedData = json.decode(response.body);
      // _firstPayment = extractedData['firstPayment'];
      // UPDATE
      _quantityById = listClothesBoughtById.length;
      notifyListeners();
    }

    http.patch(urlQuantityById,
        body: json.encode({'quantityById': _quantityById}));

    print("Jumlah baju id = $id adalah $_quantityById");
    print("buys = $_buys");
  }

  Future<void> createPayment(String userId, String authToken) async {
    final urlTotalPerId =
        'https://pakaimart-177c9.firebaseio.com/totalPerId/$userId.json?auth=$authToken';
    final urlSetOfClothes =
        'https://pakaimart-177c9.firebaseio.com/setOfClothes/$userId.json?auth=$authToken';
    final urlTotalItems =
        'https://pakaimart-177c9.firebaseio.com/totalItems/$userId.json?auth=$authToken';
    final urlBuys =
        'https://pakaimart-177c9.firebaseio.com/buys/$userId.json?auth=$authToken';
    final response = await http.get(urlBuys);
    final extractedData = json.decode(response.body);
    final buysPerId = extractedData['buysPerId'] as List<dynamic>;
    print('buysPerId = $buysPerId');
    final setOfClothesPerId = buysPerId.toSet().toList();
    print('setOfClothesPerId = $setOfClothesPerId');
    _setOfClothes = [];
    _totalPerId = [];
    int sum;
    //var temp = buysPerId[0];
    //int i;

    // buysPerId.forEach((id) {
    //   if (id == temp) {
    //     i++;
    //     sum += 1;
    //     print('sum ditambah');
    //   } else {
    //     temp = id;
    //     i++;
    //     _totalPerId.add(sum);
    //     print('list ditambah1');
    //     sum = 1;
    //   }
    //   if (i == buysPerId.length) {
    //     _totalPerId.add(sum);
    //     print('list ditambah2');
    //   }
    // });
    // http.patch(urlTotalPerId, body: json.encode({'totalPerId': _totalPerId}));

    // make a list of total clothes per id

    setOfClothesPerId.forEach((idInSet) {
      sum = 0;
      buysPerId.forEach((idInBuys) {
        if (idInBuys == idInSet) {
          sum++;
          // buysPerId.remove(idInBuys);
          // buysPerId.join(', ');
          print('buysPerId --> $buysPerId');
        }
      });
      _totalPerId.add(sum);
    });
    print('Total per id = $_totalPerId');

    // Create Set and convert to List

    http.patch(urlSetOfClothes,
        body: json.encode({'setOfClothesPerId': setOfClothesPerId}));
    setOfClothesPerId.forEach((id) {
      var womanOverview = _womanOverviews.firstWhere((wov) => wov.id == id);
      _setOfClothes.add(womanOverview);
    });

    // Total Items
    _totalItems = setOfClothesPerId.length;
    http.patch(urlTotalItems, body: json.encode({'totalItems': _totalItems}));

    print('Himpunan baju yang dibeli: $_setOfClothes');
    print('Finish createPayment()...');
  }

  Future<void> calculateTotalPayment(String userId, String authToken) async {
    final url =
        'https://pakaimart-177c9.firebaseio.com/totalPayment/$userId.json?auth=$authToken';
    _totalPayment = 0;
    var indexTotalPerId = 0;

    // GET _setOfClothes and _totalPerId from Server
    _setOfClothes.forEach((wov) {
      _totalPayment += wov.price * _totalPerId[indexTotalPerId];
      indexTotalPerId++;
    });
    http.patch(url, body: json.encode({'totalPayment': _totalPayment}));
    print('Total yang hrs dibayarkan = $_totalPayment');
  }

  Future<void> reset(String userId, String authToken) async {
    final urlAmountOfShoppingBag =
        'https://pakaimart-177c9.firebaseio.com/amountOfShoppingBag/$userId.json?auth=$authToken';
    final urlFirstPayment =
        'https://pakaimart-177c9.firebaseio.com/firstPayment/$userId.json?auth=$authToken';
    final urlQuantityById =
        'https://pakaimart-177c9.firebaseio.com/quantityById/$userId.json?auth=$authToken';
    final urlBuysAfterFirstPayment =
        'https://pakaimart-177c9.firebaseio.com/buysAfterFirstPayment/$userId.json?auth=$authToken';
    final responseBuysAfterFirstPayment =
        await http.get(urlBuysAfterFirstPayment);
    final extractedDataBuysAfterFirstPayment =
        json.decode(responseBuysAfterFirstPayment.body);

    print('reset');
    _amountOfShoppingBag = 0;
    _firstPayment = true;
    await http.patch(urlAmountOfShoppingBag,
        body: json.encode({'amountOfShoppingBag': 0}));
    await http.delete(urlQuantityById);
    await http.patch(urlFirstPayment,
        body: json.encode({'firstPayment': true}));
    if (extractedDataBuysAfterFirstPayment != null) {
      await http.delete(urlBuysAfterFirstPayment);
      print('delete buysAfterFirstPayment...');
    }

    print('finish reset...');
  }

  Future<void> finishPayment(String authToken, String userId) async {
    print('Finish Payment');
    //fetch data from server
    final url =
        'https://pakaimart-177c9.firebaseio.com/isFinishPayment/$userId.json?auth=$authToken';
    // final response = await http.get(url);
    // final extractedData = json.decode(response.body);
    try {
      await http.patch(url, body: json.encode({'isFinishPayment': true}));
      _isFinishPayment = true;
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }
}
