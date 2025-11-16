class PostLikeModel {
  bool? success;
  String? message;
  Data? data;

  PostLikeModel({this.success, this.message, this.data});

  PostLikeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? postId;
  bool? liked;
  String? likeCount;

  Data({this.postId, this.liked, this.likeCount});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    liked = json['is_liked'];
    likeCount = json['like_count'];
  }
}