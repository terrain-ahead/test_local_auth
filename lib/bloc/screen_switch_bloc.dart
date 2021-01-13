import 'dart:async';
import 'package:test_local_auth/elements/elements.dart';
import 'package:test_local_auth/repo/get_cards_with_authorization.dart';
import 'package:rxdart/subjects.dart';

enum Screens { LOGIN, MAINPAGE, ERROR }

class ScreenSwitch {
  final StreamController<Screens> _screensController = BehaviorSubject();
  Screens defaultScreen = Screens.LOGIN;
  Stream<Screens> get screen => _screensController.stream;
  Sink get screenSink => _screensController.sink;

  void pickScreen(int screenId) {
    switch (screenId) {
      case 0:
        screenSink.add(Screens.LOGIN);
        break;
      case 1:
        screenSink.add(Screens.MAINPAGE);
        break;
      default:
        break;
    }
  }

  close() {
    _screensController?.close();
  }

  void checkScreen(var email, var password) async {
    if (email != null && password != null) {
      buildLoadingWidget();
      await loginAndOut.LogIn(email, password);
      pickScreen(1);
    } else {
      pickScreen(0);
    }
  }
}

final ScreenSwitch screenSwitch = ScreenSwitch();
