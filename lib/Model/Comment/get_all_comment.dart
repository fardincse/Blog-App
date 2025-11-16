class GetComment {
  bool? success;
  String? message;
  Data? data;

  GetComment({this.success, this.message, this.data});

  GetComment.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Comments>? comments;
  Pagination? pagination;

  Data({this.comments, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class Comments {
  int? id;
  int? postId;
  int? userId;
  int? parentId;
  String? content;
  int? likesCount;
  String? createdAt;
  String? updatedAt;
  Author? author;
  List<Replies>? replies;
  bool? isLiked;

  Comments({
    this.id,
    this.postId,
    this.userId,
    this.parentId,
    this.content,
    this.likesCount,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.replies,
    this.isLiked,
  });

  Comments.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    postId = int.tryParse(json['post_id'].toString());
    userId = int.tryParse(json['user_id'].toString());
    parentId = int.tryParse(json['parent_id'].toString());
    content = json['content'];
    likesCount = int.tryParse(json['likes_count'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
    isLiked = json['is_liked'];
  }
}

class Author {
  int? id;
  String? name;
  String? email;
  String? avatar;

  Author({this.id, this.name, this.email, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }
}

class Replies {
  int? id;
  int? postId;
  int? userId;
  int? parentId;
  String? content;
  int? likesCount;
  String? createdAt;
  Author? author;
  bool? isLiked;

  Replies({
    this.id,
    this.postId,
    this.userId,
    this.parentId,
    this.content,
    this.likesCount,
    this.createdAt,
    this.author,
    this.isLiked,
  });

  Replies.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    postId = int.tryParse(json['post_id'].toString());
    userId = int.tryParse(json['user_id'].toString());
    parentId = int.tryParse(json['parent_id'].toString());
    content = json['content'];
    likesCount = int.tryParse(json['likes_count'].toString());
    createdAt = json['created_at'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    isLiked = json['is_liked'];
  }
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? totalComments;
  int? totalPages;

  Pagination({
    this.currentPage,
    this.perPage,
    this.totalComments,
    this.totalPages,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = int.tryParse(json['current_page'].toString());
    perPage = int.tryParse(json['per_page'].toString());
    totalComments = int.tryParse(json['total_comments'].toString());
    totalPages = int.tryParse(json['total_pages'].toString());
  }
}
