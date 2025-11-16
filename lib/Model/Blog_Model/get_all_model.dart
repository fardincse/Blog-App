class GetAllBlog {
  bool? success;
  String? message;
  Data? data;

  GetAllBlog({this.success, this.message, this.data});

  GetAllBlog.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? '';
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Post>? posts;

  Data({this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = (json['posts'] as List)
          .map((v) => Post.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }
}

class Post {
  int? id;
  String? title;
  String? excerpt;
  String? content;
  String? featuredImage;
  Author? author;
  List<String>? categories;
  int? readTime;
  String? createdAt;
  int? likeCount;
  int? commentCount;
  bool? isLiked;
  bool? isBookmarked;

  Post({
    this.id,
    this.title,
    this.excerpt,
    this.content,
    this.featuredImage,
    this.author,
    this.categories,
    this.readTime,
    this.createdAt,
    this.likeCount,
    this.commentCount,
    this.isLiked,
    this.isBookmarked,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    title = json['title'] ?? '';
    excerpt = json['excerpt'] ?? '';
    content = json['content'] ?? '';
    featuredImage = json['featured_image'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    categories = (json['categories'] as List?)?.map((e) => e.toString()).toList();
    readTime = _toInt(json['read_time']);
    createdAt = json['created_at'] ?? '';
    likeCount = _toInt(json['like_count']);
    commentCount = _toInt(json['comment_count']);
    isLiked = json['is_liked'] ?? false;
    isBookmarked = json['is_bookmarked'] ?? false;
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

  Author({this.id, this.name, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    name = json['name'] ?? '';
    avatar = json['avatar'];
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
