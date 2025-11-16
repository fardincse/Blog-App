import 'dart:convert';

import 'package:blog_app/Model/Blog_Model/single_blog_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future fetchSingleBlog(int id) async{
  final baseUrl = dotenv.env['singlePostUrl'];

  try{
    if(baseUrl == null){
      throw Exception('Url not fopund');
    }
    final response = await http.get(
      Uri.parse('$baseUrl$id'),
      headers: <String, String>{
        'Content-Type' : 'application/json' 
      }
    );
    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);
      return SingleBlogModel.fromJson(decodedData);
    }else{
      throw Exception(response.statusCode);
    }
  }catch(e){
    print(e);
  }
}