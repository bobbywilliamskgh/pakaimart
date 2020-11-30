import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pakai_mart/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireDate;
  String _userId;
  String _email;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _expireDate != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCasZG7gY3lIOgfIo8Low34cyAdKi3SXSE';

    try {
      final result = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print(result.statusCode);
      print(json.decode(result.body));
      final response = json.decode(result.body);
      if (response['error'] != null) {
        print('HttpException');
        print(response['error']['message']);
        throw HttpException(response['error']['message']);
      }
      _token = response['idToken'];
      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(response['expiresIn'])));
      _userId = response['localId'];
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expireDate': _expireDate.toIso8601String(),
        'email': email
      });
      pref.setString('userData', userData);
      _email = email;
    } catch (error) {
      print(error);
      throw HttpException(error.toString());
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(pref.getString('userData')) as Map<String, dynamic>;
    final expireDate = DateTime.parse(extractedUserData['expireDate']);
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _email = extractedUserData['email'];
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expireDate = expireDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    print('Logout');
    _token = null;
    _userId = null;
    _expireDate = null;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
