import 'package:blog_app/Model/Blog_Model/single_blog_model.dart';
import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier{
  SingleBlogModel? _blog;
  SingleBlogModel? get blog => _blog;

  void singleBlog(SingleBlogModel blog){
    _blog = blog;
    notifyListeners();
  }

  void toggleLike(bool inLove){

  }


  // void inLove(int tlove){
  //   like = tlove + 1;
  //   notifyListeners();
  // }
  // void disLove(int tlove){
  //   like = tlove - 1;
  //   notifyListeners();
  // }
}