import 'dart:convert';

import 'package:blog_app/Model/Like/get_user_like_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future getUserLikeBlog() async{
  final baseUrl = dotenv.env['baseUrl'];
  final box = GetStorage();
  final token = box.read('token');
  try{
    if (baseUrl == null) {
      throw Exception('Url not found');
    }
    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/user/likes'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);
      return GetUserLikeModel.fromJson(decodedData);
    } else{
      throw Exception(response.statusCode);
    }
  }catch(e){
    print('$e');
  }
}