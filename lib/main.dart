import 'package:flutter/material.dart';
import 'package:test_local_auth/bloc/screen_switch_bloc.dart';
import 'package:test_local_auth/screen/pagetwo.dart';
import 'package:test_local_auth/style/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  var password = preferences.getString("password");
  screenSwitch.checkScreen(email, password);

  runApp(
    StreamBuilder(
        stream: screenSwitch.screen,
        initialData: screenSwitch.defaultScreen,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case Screens.LOGIN:
              return MaterialApp(
                home: Login(),
                theme: primaryTheme,
                debugShowCheckedModeBanner: false,
              );
            case Screens.MAINPAGE:
              return MaterialApp(
                home: PageTwo(),
                theme: primaryTheme,
                debugShowCheckedModeBanner: false,
              );
            default:
              return Container();
              break;
          }
        }),
  );
}
