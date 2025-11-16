import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> addComent(int postId, String comment) async {
  final box = GetStorage();
  final baseUrl = dotenv.env['ADDCOMMENT'];
  final token = box.read('token');
  try {
    if (baseUrl == null) {
      throw Exception('Url not found');
    }
    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"post_id": postId, "content": comment}),
    );
    if (response.statusCode == 201) {
      return "Comment added successfully";
    } else if (response.statusCode == 401) {
      return "Unauthorized ";
    } else if (response.statusCode == 404) {
      return "Post not found";
    }
    return "Somthing went wrong";
  } catch (e) {
    print(e);
    return '$e';
  }
}
