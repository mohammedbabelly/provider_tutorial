import 'package:flutter/material.dart';

class counter with ChangeNotifier {
  int cnt = 99;

  incCnt() {
    cnt++;
    notifyListeners();
  }
}
