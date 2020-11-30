import 'package:flutter/foundation.dart';
import '../models/user_reciever_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListOfUserReciever with ChangeNotifier {
  // Method :
  Future<void> addListOfUserReciever(
      UserReciever userReciever, String authToken, String userId) async {
    final listOfId = []; // List Of Clothes Id
    userReciever.setOfClothes.forEach((wov) {
      listOfId.add(wov.id);
    });
    final url =
        'https://pakaimart-177c9.firebaseio.com/users_receiver/$userId.json?auth=$authToken';
    await http.post(url,
        body: json.encode({
          'name': userReciever.name,
          'userNumber': userReciever.userNumber,
          'userAtmNumber': userReciever.userAtmNumber,
          'address': userReciever.address,
          'listOfId': listOfId,
          'totalPerId': userReciever.totalPerId,
          'totalPayment': userReciever.totalPayment,
          //'isFinishPayment': true,
        }));
    print(userReciever.address);
    //_listOfUserReciever.add(userReciever);
  }
}
