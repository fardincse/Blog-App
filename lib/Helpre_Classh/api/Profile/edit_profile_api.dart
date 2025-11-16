import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

Future editUser(String name, String phone) async {
  final baseUrl = dotenv.env['GETUSERPROFILE'];
  final box = GetStorage();
  final token = box.read('token');

  try {
    if (baseUrl == null) {
      throw Exception('Url not found');
    }
    if (token == null) {
      throw Exception('token not found');
    }

    final response = await http.put(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"name": name, "phone": phone})
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    print('$e');
  }
}
