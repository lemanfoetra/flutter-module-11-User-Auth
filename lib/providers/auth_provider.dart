import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {

  String _localId;
  String _idToken;
  DateTime _expiresIn;


  // Untuk idUser
  String get idUser {
    return _localId;
  }



  // Untuk pengecekan apakah sudah/masih auth atau tidak
  bool get isAuth{
    if(_notExpiresToken){
      return true;
    }
    return false;
  }


   // Untuk pengecekan apakah apakah token masih berlaku atau tidak
  bool get _notExpiresToken{
    if(_expiresIn != null && _idToken != null){
      if(DateTime.now().isBefore(_expiresIn)){
        return true;
      }
    }
    return false;
  }


  // Mendapatkan id token
  String get idToken{
    if(_notExpiresToken){
      return _idToken;
    }
    return null;
  }


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

      _idToken = responseData['idToken'];
      _expiresIn = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _localId = responseData['localId'];
      notifyListeners();

    } catch (error) {
      throw error;
    }
  }



  // funtion untuk keluar login
  void logout(){
    _idToken = null;
    _localId = null;
    _expiresIn = null;
    notifyListeners();
  }


}
