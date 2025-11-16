import 'dart:convert';
import 'package:blog_app/Model/Blog_Model/get_all_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future searchBlog(que) async{
  final baseUrl = dotenv.env['searchUrl'];

  try{
    if(baseUrl == null){
      throw Exception('Url not found');
    }
    final response = await http.get(
      Uri.parse('$baseUrl?q=$que'),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
       final decodedData = jsonDecode(response.body);
       return GetAllBlog.fromJson(decodedData);
    } else{
      throw Exception(response.statusCode);
    }
  } catch(e){
    print('$e');
  }
}