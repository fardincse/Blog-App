class GetFromLogin {
  bool success;
  String message;
  Data? data;

  GetFromLogin({
    required this.success,
    required this.message,
    this.data,
  });

  factory GetFromLogin.fromJson(Map<String, dynamic> json) {
    return GetFromLogin(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  User? user;
  String? token;
  String? tokenType;
  int? expiresIn;

  Data({this.user, this.token, this.tokenType, this.expiresIn});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;

  User({this.id, this.name, this.email, this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
