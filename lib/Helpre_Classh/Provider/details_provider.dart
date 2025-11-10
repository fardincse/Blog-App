import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier{
  String _title = '';
  String _imagePath = '';

  String get title => _title;
  String get imagePath => _imagePath;

  void details(String title, String image){
    _title = title;
    _imagePath = image;
    notifyListeners();
  }
}