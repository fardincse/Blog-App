import 'package:blog_app/Helpre_Classh/api/All_Blog/all_blog_api.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/Model/Blog_Model/get_all_model.dart';

class BlogProvider with ChangeNotifier{
  Data? _allBlogs;
  bool isLodding = false;
  Data? get allBlogs => _allBlogs;

  Future<Data?> addBlogs() async{
    if(_allBlogs != null){
      return _allBlogs;
    }
    try{
    isLodding = true;
    notifyListeners();
    final response = await fetchBlog();
    if(response != null){
      _allBlogs = response.data;
    }
    isLodding = false;
    notifyListeners();
      return _allBlogs;
    }catch(e){
      isLodding = false;
      notifyListeners();
      return null;
    }
  }
}