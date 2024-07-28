import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier{
  String token='';
  changeToken(String newToken){
    if(newToken == token){
      return;
    }else{
      token = newToken;
    }
    notifyListeners();
  }
}