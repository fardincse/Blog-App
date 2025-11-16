import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:blog_app/Model/Blog_Model/get_all_model.dart';

Future fetchBlog() async{
  final baseUrl = dotenv.env['allPostUrl'];
  try{
    if(baseUrl == null){
    throw Exception('Url not found');
  }
    final response = await http.get(
    Uri.parse(baseUrl),
    headers: <String, String>{
      'Content-Type' : 'application/json'
    },
  );
  if(response.statusCode == 200){
    final decodedData = jsonDecode(response.body);
    return GetAllBlog.fromJson(decodedData);
  }
  else{
     throw Exception('Somtheing went wrong');
  }
  }catch(e){
    print(e);
  }
}