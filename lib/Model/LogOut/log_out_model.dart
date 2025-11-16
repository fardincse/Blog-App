class LogOutModel {
  bool? success;
  String? message;

  LogOutModel({this.success, this.message});

  LogOutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}