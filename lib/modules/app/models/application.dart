import 'package:flutter/material.dart';

class Application extends ChangeNotifier {
  int _bottomTabIndex = 0;

  int get currentBottomTabIndex => _bottomTabIndex;

  void selectTab(int index) {
    _bottomTabIndex = index;
    notifyListeners();
  }
}
