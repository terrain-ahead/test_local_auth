import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_local_auth/model/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_local_auth/screen/login.dart';

class LoginAndOut {
  List<Cards> cards = List<Cards>();

  Future<bool> LogIn(String email, String password) async {
    String auth = email + ':' + password;
    String encoded = base64.encode(utf8.encode(auth));
    var url = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/';
    var headers = {'Authorization': 'Basic ' + encoded};
    var response = await http.get(url, headers: headers);
    String utfstring = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      List responseJson = jsonDecode(utfstring);
      for (int i = 0; i < responseJson.length; i++) {
        cards.add(Cards(
            id: responseJson[i]['id'].toString(),
            row: responseJson[i]['row'].toString(),
            seq_num: responseJson[i]['seq_num'].toString(),
            text: responseJson[i]['text'].toString()));
      }
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  List<Cards> getCards() => cards;

  Future<void> LogOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('password');
    loginAndOut.cards.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }
}

LoginAndOut loginAndOut = LoginAndOut();
