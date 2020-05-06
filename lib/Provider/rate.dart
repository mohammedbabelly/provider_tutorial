import 'package:flutter/material.dart';

class RateNotifier extends ChangeNotifier {
  double rate = 0;

  changeRating(double newValue) {
    rate = newValue;
    notifyListeners();
  }
}
