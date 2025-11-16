class GetLikeCount {
  bool? success;
  String? message;
  Data? data;

  GetLikeCount({this.success, this.message, this.data});

  GetLikeCount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? postId;
  List<Likes>? likes;
  String? totalLikes;
  Pagination? pagination;

  Data({this.postId, this.likes, this.totalLikes, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    totalLikes = json['total_likes'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class Likes {
  User? user;
  String? likedAt;

  Likes({this.user, this.likedAt});

  Likes.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    likedAt = json['liked_at'];
  }
}

class User {
  String? id;
  String? name;
  String? avatar;

  User({this.id, this.name, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? totalPages;

  Pagination({this.currentPage, this.perPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
  }
}