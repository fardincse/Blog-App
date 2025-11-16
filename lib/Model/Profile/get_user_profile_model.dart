class GetUserProfileModel {
  bool? success;
  String? message;
  Data? data;

  GetUserProfileModel({this.success, this.message, this.data});

  GetUserProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? registeredDate;

  User({this.id, this.name, this.email, this.phone, this.registeredDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    registeredDate = json['registered_date'];
  }
}