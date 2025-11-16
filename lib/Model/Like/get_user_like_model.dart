class GetUserLikeModel {
  bool? success;
  String? message;
  Data? data;

  GetUserLikeModel({this.success, this.message, this.data});

  GetUserLikeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Posts>? posts;

  Data({this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }
}

class Posts {
  String? id;
  String? title;
  String? excerpt;
  String? featuredImage;
  Author? author;
  String? createdAt;
  String? likeCount;
  bool? isLiked;

  Posts(
      {this.id,
      this.title,
      this.excerpt,
      this.featuredImage,
      this.author,
      this.createdAt,
      this.likeCount,
      this.isLiked});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    excerpt = json['excerpt'];
    featuredImage = json['featured_image'];
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    createdAt = json['created_at'];
    likeCount = json['like_count'];
    isLiked = json['is_liked'];
  }
}

class Author {
  String? name;

  Author({this.name});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

