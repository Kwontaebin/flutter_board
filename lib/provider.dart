import 'package:flutter/material.dart';

class IdProvider with ChangeNotifier {
  late int _id;
  String _name = "";
  late int _pageNum = 0;

  int get id => _id;
  String get name => _name;
  int get pageNum => _pageNum;

  void setId(int newId, String newName, int pageNum) {
    _id = newId;
    _name = newName;
    _pageNum = pageNum;
    notifyListeners();
  }
}