import 'package:flutter/material.dart';

class BookmarksProvider with ChangeNotifier{

  final List<Map<String, dynamic>> _bookmarksBlogs = [];
  List<Map<String, dynamic>> get bookmarksBlog => _bookmarksBlogs;

  void addTOBookmarks(Map<String, dynamic> blog){
    _bookmarksBlogs.add(blog);
    notifyListeners();
  }

  void removeFromBookmarks(Map<String, dynamic> blog){
    _bookmarksBlogs.removeWhere((element) => element['title'] == blog['title'] && element['image'] == blog['image']);
    notifyListeners();
  }

  bool inBookmark(Map<String, dynamic> blog){
    return _bookmarksBlogs.any((element) => element['title'] == blog['title'] && element['image'] == blog['image']);
  }
}