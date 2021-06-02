import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  MyProvider() {
    print('hello');
  }
  String name = 'login';
  changeName(String value) {
    this.name = value;
    notifyListeners();
  }
}
