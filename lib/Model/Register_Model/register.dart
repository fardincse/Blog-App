class RegisterModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

class FromRegister {
  bool success;
  String message;
  List<Errors>? error;

  FromRegister({required this.success, required this.message, this.error});

  factory FromRegister.fromJson(Map<String, dynamic> json) {
     List<Errors>? errorsList;
    if (json['errors'] != null) {
      errorsList = <Errors>[];
      json['errors'].forEach((v) {
        errorsList!.add(Errors.fromJson(v));
      });
    }
    return FromRegister(success: json['success'], message: json['message'], error: errorsList!);
  }
}
class Errors {
  String? message;

  Errors({this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
