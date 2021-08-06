import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class check with ChangeNotifier {
  bool val = false;
  clicked() {
    this.val = !val;
    notifyListeners();
  }
}
