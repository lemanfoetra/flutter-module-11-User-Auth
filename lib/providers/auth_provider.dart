import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {


  // Untuk daftar pengguna baru
  Future<void> singnup(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCjj3zdfJ_-fE9_48AomHK8RI8yLF6npho";

    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(json.decode(response.body));
  }
}
