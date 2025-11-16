import 'package:flutter/material.dart';
import 'package:blog_app/Helpre_Classh/Database/database_helper.dart';

class BookmarksProvider with ChangeNotifier{

  final dbHelper = DatabaseHelper.getIntance;
  List<Map<String, dynamic>> _bookmarksBlogs = [];
  List<Map<String, dynamic>> get bookmarksBlog => _bookmarksBlogs;
  bool? _isbookmarks;
  bool? get isbookmarks => _isbookmarks;

  Future bookmarks() async{
    final response = await dbHelper.fetchBookmarks();
    _bookmarksBlogs = response;
    return _bookmarksBlogs;
  }

  Future addTOBookmarks(Map<String, dynamic> blog) async{
    await dbHelper.insertBookMark(blog);
    await inBookmark(blog['id']);
    await bookmarks();
    notifyListeners();
  }

  Future removeFromBookmarks(int id) async{
    await dbHelper.deleteBookmarks(id);
    await inBookmark(id);
    await bookmarks();
    notifyListeners();
  }

  Future<bool> inBookmark(int id) async{
    final response = await dbHelper.isBookmarks(id);
    _isbookmarks = response;
    notifyListeners();
    return _isbookmarks!;
  }
}