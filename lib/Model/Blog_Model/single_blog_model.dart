class SingleBlogModel {
  bool? success;
  String? message;
  Data? data;

  SingleBlogModel({this.success, this.message, this.data});

  SingleBlogModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Post? post;

  Data({this.post});

  Data.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }
}

class Post {
  int? id;
  String? title;
  String? content;
  String? excerpt;
  String? featuredImage;
  Author? author;
  List<String>? categories;
  List<String>? tags;
  int? readTime;
  String? createdAt;
  String? updatedAt;
  int? likeCount;
  int? commentCount;
  bool? isLiked;

  Post(
      {this.id,
      this.title,
      this.content,
      this.excerpt,
      this.featuredImage,
      this.author,
      this.categories,
      this.tags,
      this.readTime,
      this.createdAt,
      this.updatedAt,
      this.likeCount,
      this.commentCount,
      this.isLiked,
    });

  Post.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    title = json['title'];
    content = json['content'];
    excerpt = json['excerpt'];
    featuredImage = json['featured_image'];
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    categories = json['categories'].cast<String>();
    tags = json['tags'].cast<String>();
    readTime = _toInt(json['read_time']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likeCount = _toInt(json['like_count']);
    commentCount = _toInt(json['comment_count']);
    isLiked = json['is_liked'];
  }
   int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class Author {
  int? id;
  String? name;
  String? avatar;
  String? bio;

  Author({this.id, this.name, this.avatar, this.bio});

  Author.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    name = json['name'];
    avatar = json['avatar'];
    bio = json['bio'];
  }
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}