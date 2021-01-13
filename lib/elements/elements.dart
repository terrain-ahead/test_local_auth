import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_local_auth/model/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_local_auth/repo/get_cards_with_authorization.dart';
import 'package:test_local_auth/screen/pagetwo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void MsgToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}

List<Card> Populate(List<Cards> cards) {
  print("Hi bitch im in Populate" + cards.length.toString());
  int n = cards.length;
  List<Card> l = new List(n);
  for (int i = 0; i < n; i++) {
    l[i] = Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: ListTile(
        title: Text("ID " + cards[i].id.toString()),
        subtitle: Text(cards[i].text.toString()),
      ),
    );
  }
  return l;
}

changeThePage(BuildContext context, String email, String password) async {
  bool loggedIn = await loginAndOut.LogIn(email, password);
  SharedPreferences preferences = await SharedPreferences.getInstance();
//  if (loggedIn) {
    MsgToast("Successfully logged in");
    preferences.setString("email", email);
    preferences.setString("password", password);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => PageTwo()));
//  } else {
//    print("Couldn't login");
//    MsgToast("Couldn't login");
//  }
}

Widget buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 100.0,
        width: 100.0,
        child: SpinKitDoubleBounce(
          size: 50,
          color: Colors.teal,
        ),
      )
    ],
  ));
}
