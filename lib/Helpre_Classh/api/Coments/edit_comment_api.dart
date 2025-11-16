import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

Future editComment(int commentId, String comment) async {
  final baseUrl = dotenv.env['DELETECOMMENT'];
  final box = GetStorage();
  final token = box.read('token'); 

  try{
    if (baseUrl == null) {
      throw Exception('Url not found');
    }
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.put(
      Uri.parse('$baseUrl$commentId'),
      headers: <String, String>{
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      body: jsonEncode({"content": comment})
    );
    if(response.statusCode == 200){
      return "Comment sucessfully update";
    } else{
      return "Somthing went wrong";
    }
  }catch(e){
    return '$e';
  }
}