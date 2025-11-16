import 'package:blog_app/Helpre_Classh/api/Like/get_like_count_api.dart';
import 'package:blog_app/Helpre_Classh/api/Like/get_user_like_api.dart';
import 'package:blog_app/Helpre_Classh/api/Like/post_like_api.dart';
import 'package:blog_app/Model/Like/get_user_like_model.dart';
import 'package:blog_app/Model/Like/like_count_model.dart';
import 'package:blog_app/Model/Like/post_like_model.dart';
import 'package:flutter/material.dart';

class LikeProvider with ChangeNotifier {
  GetUserLikeModel? _userLike;
  GetUserLikeModel? get userLike => _userLike;
  GetLikeCount? _likeCount;
  GetLikeCount? get likeCount => _likeCount;
  PostLikeModel? _postLike;
  PostLikeModel? get postLike => _postLike;

  Future getUserLike() async {
    final data = await getUserLikeBlog();
    _userLike = data;
    notifyListeners();
  }

  Future getLikeCount(int postId) async {
    final data = await fetchLikeCount(postId);
    _likeCount = data;
    notifyListeners();
    return _likeCount;
  }

  Future likeBlog(int postId) async {
    _postLike = await postLikeBlog(postId);

    _likeCount = await getLikeCount(postId);
    _userLike = await getUserLikeBlog();

    notifyListeners();
  }
}
