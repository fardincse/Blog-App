import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:blog_app/Model/Login_Model/post_login_model.dart';
import 'package:blog_app/Model/Login_Model/get_from_login.dart';

Future userLogin(PostLoginModel model) async {
  final loginUrl = dotenv.env['LOGINURL'];
  if (loginUrl == null) {
    throw Exception('API URL is null! Check your .env file and key.');
  }
  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({"email": model.email, "password": model.password}),
    );
    final decodedData = jsonDecode(response.body);
    return GetFromLogin.fromJson(decodedData);
    
  } catch (e) {
    print(e);
  }
}
