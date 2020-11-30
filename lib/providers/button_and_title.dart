import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ButtonAndTitle with ChangeNotifier {
  // Properties :

  // Universal ( To All Authenticated User )

  // Spesific ( To Spesific Authenticated User )

  bool _isBagTaken;
  bool _isGoToCasheer;
  String _instruction;

  // Getter

  bool get isBagTaken {
    return _isBagTaken;
  }

  bool get isGoToCasheer {
    return _isGoToCasheer;
  }

  String get instruction {
    return _instruction;
  }

  // METHOD

  Future<void> checkIsGoToCasheer(String userId, String authToken) async {
    // It should be return Future<void>
    final url =
        'https://pakaimart-177c9.firebaseio.com/isGoToCasheer/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    final isGoToCasheerFromServer = extractedData['isGoToCasheer'];
    _isGoToCasheer = isGoToCasheerFromServer;
  }

  Future<void> checkIsBagTaken(String userId, String authToken) async {
    print('CheckIsBagTaken start...');
    // It should be return Future<void>
    final url =
        'https://pakaimart-177c9.firebaseio.com/isBagTaken/$userId.json?auth=$authToken';
    try {
      // GET from Server
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        _isBagTaken =
            false; // If user add clothes or remove clothes in detail screen but haven't take shopping bag
        http.patch(url, body: json.encode({'isBagTaken': false}));
        return;
      }
      _isBagTaken = extractedData['isBagTaken'];
    } catch (error) {
      throw error;
    }
  }

  Future<void> getInstruction(
      // It should be return Future<void>
      String userId,
      String authToken) async {
    final url =
        'https://pakaimart-177c9.firebaseio.com/instruction/$userId.json?auth=$authToken';
    try {
      var instruction = 'Ambil';
      var response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        await http.patch(url, body: json.encode({'instruction': 'Ambil'}));
        _instruction = instruction;
        print('getInstruction'); // Untuk debugging
        return;
      }
      instruction = extractedData['instruction'];
      print('instruction dari server = $instruction');
      _instruction = instruction;
      print('getInstruction'); // Untuk debugging
    } catch (error) {
      print('error...');
    }
  }

  Future<void> updateInstruction(
      int totalInBag, String userId, String authToken) async {
    print('update instruction...');
    final url =
        'https://pakaimart-177c9.firebaseio.com/instruction/$userId.json?auth=$authToken';

    try {
      // GET _isBagTaken & _isGoToCasheer
      if (totalInBag == 0) {
        if (_isBagTaken) {
          // UPDATE _instruction
          await http.patch(url,
              body: json.encode({'instruction': 'Anda belum membeli apapun'}));
          _instruction = 'Anda belum membeli apapun';
        } else {
          // UPDATE _instruction
          await http.patch(url, body: json.encode({'instruction': 'Ambil'}));
          _instruction = 'Ambil';
        }
      } else {
        if (isGoToCasheer && !_isBagTaken) {
          // UPDATE _instruction
          await http.patch(url, body: json.encode({'instruction': 'Ambil'}));
          _instruction = 'Ambil';
        } else {
          // UPDATE _instruction
          await http.patch(url,
              body: json.encode({'instruction': 'Bawa tas ke kasir'}));
          _instruction = 'Bawa tas ke kasir';
        }
      }
    } catch (error) {
      throw error;
    }
  }

  dynamic onPressedButton(Function selectedButton, int totalInBag,
      bool isFinishPayment, String userId, String authToken) {
    print('start onPressedButton()');
    final urlIsBagTaken =
        'https://pakaimart-177c9.firebaseio.com/isBagTaken/$userId.json?auth=$authToken';
    final urlIsGoToCasheer =
        'https://pakaimart-177c9.firebaseio.com/isGoToCasheer/$userId.json?auth=$authToken';
    // UPDATE
    if (_instruction == 'Anda belum membeli apapun' && totalInBag == 0 ||
        isFinishPayment) {
      print(totalInBag);
      return null;
    } else {
      return () async {
        print('return fungsi di onPressedButton()');
        // dynamic responseIsBagTaken;
        // dynamic responseIsGoToCasheer;
        // Map<String, dynamic> extractedDataIsBagTaken;
        // Map<String, dynamic> extractedDataIsGoToCasheer;
        if (_instruction == 'Ambil') {
          // UPDATE _isBagTaken & _isGoToCasheer
          selectedButton(2);
          // Locally
          _isBagTaken = true;
          _isGoToCasheer = false;
          await updateInstruction(totalInBag, userId, authToken);

          // Update to Server
          // final responseIsBagTaken = await http.get(urlIsBagTaken);
          // final responseIsGoToCasheer = await http.get(urlIsGoToCasheer);
          // extractedDataIsBagTaken = json.decode(responseIsBagTaken.body);
          // extractedDataIsGoToCasheer = json.decode(responseIsGoToCasheer.body);
          // if (extractedDataIsBagTaken == null &&
          //     extractedDataIsGoToCasheer == null) {
          //   await http.patch(urlIsBagTaken,
          //       body: json.encode({'isBagTaken': true}));
          //   _isBagTaken = true;
          //   await http.patch(urlIsGoToCasheer,
          //       body: json.encode({'isGoToCasheer': false}));
          //   _isGoToCasheer = false;
          //   await updateInstruction(totalInBag, userId, authToken);
          //   return;
          // }
          await http.patch(urlIsBagTaken,
              body: json.encode({'isBagTaken': true}));

          await http.patch(urlIsGoToCasheer,
              body: json.encode({'isGoToCasheer': false}));
        } else if (_instruction == 'Bawa tas ke kasir') {
          // UPDATE _isBagTaken & _isGoToCasheer
          selectedButton(3);
          _isGoToCasheer = true;
          _isBagTaken = false;
          await updateInstruction(totalInBag, userId, authToken);
          http.patch(urlIsGoToCasheer,
              body: json.encode({'isGoToCasheer': true}));

          http.patch(urlIsBagTaken, body: json.encode({'isBagTaken': false}));

          //updateInstruction(totalInBag, userId, authToken);
        }
      };
    }
  }
}
