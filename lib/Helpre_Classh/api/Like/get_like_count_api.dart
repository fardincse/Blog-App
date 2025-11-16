import 'dart:convert';
import 'package:blog_app/Model/Like/like_count_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

Future fetchLikeCount(int postId) async{
  final baseUrl = dotenv.env['singlePostUrl'];
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
      Uri.parse('$baseUrl$postId/likes'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);
      return GetLikeCount.fromJson(decodedData);
    } else{
      throw Exception(response.statusCode);
    }
  }catch(e){
    print('$e');
  }
}