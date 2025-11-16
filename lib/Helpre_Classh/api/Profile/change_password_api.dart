import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

Future changePassword(String oldPass, String newPass) async {
  final baseUrl = dotenv.env['CHANGEPASSWORD'];
  final box = GetStorage();
  final token = box.read('token');

  try {
    if (baseUrl == null) {
      throw Exception('Url not found');
    }
    if (token == null) {
      throw Exception('token not found');
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"current_password": oldPass, "new_password": newPass})
    );
    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 401){
      return 'Invalid';
    }
     else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    print('$e');
  }
}
