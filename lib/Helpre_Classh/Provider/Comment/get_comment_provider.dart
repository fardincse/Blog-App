import 'package:blog_app/Helpre_Classh/api/Coments/add_coment.dart';
import 'package:blog_app/Helpre_Classh/api/Coments/delete_comment_api.dart';
import 'package:blog_app/Helpre_Classh/api/Coments/edit_comment_api.dart';
import 'package:blog_app/Helpre_Classh/api/Coments/get_all_coment_api.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/Model/Comment/get_all_comment.dart';

class GetCommentProvider with ChangeNotifier{
  GetComment? _allComents;
  GetComment? get allComent => _allComents;
  String? _message;
  String? get message => _message;
  String? deleteMessage;
  String? editMessage;
  

  Future<GetComment?> getComment(int id) async{
    final data = await fetchComent(id);
    _allComents = data;
    notifyListeners();
    return _allComents;
  }

  Future<void> addAndRefreshComment(int postId, String content) async {
    final res = await addComent(postId, content);
    _message = res;
    await getComment(postId);
    notifyListeners();
  }

  Future<void> deleteAndRefreshComment(int id, int postId) async{
    final res = await deleteComment(id);
    deleteMessage = res;
    await getComment(postId);
    notifyListeners();
  }

  Future<void> editAndRefreshComment(int commentId, String comment, int postId) async{
    final res = await editComment(commentId, comment);
    editMessage = res;
    await getComment(postId);
    notifyListeners();
  }

}