import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  // Untuk daftar pengguna baru
  Future<void> singnup(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCjj3zdfJ_-fE9_48AomHK8RI8yLF6npho";

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message'].toString());
      }

    } catch (error) {
      // HttpException adalah custom class exception
      throw error;
    }
  }

  // Untuk Login
  Future<void> login(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCjj3zdfJ_-fE9_48AomHK8RI8yLF6npho";

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData  = json.decode(response.body);

      // jika terjadi error auth
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

    } catch (error) {
      throw error;
    }
  }
}
