import 'dart:convert';
import 'package:blog_app/Model/Comment/get_all_comment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future fetchComent(int id) async{
  final baseUrl = dotenv.env['GETALLCOMENT'];
  try{
    if(baseUrl == null){
      throw Exception('No Url found');
    }
    final response = await http.get(
      Uri.parse('$baseUrl$id'),
      headers: <String, String>{
        'Content-type' : 'application/json',
      }
    );
    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);
      return GetComment.fromJson(decodedData);
    }else{
      throw Exception(response.statusCode);
    }
  }catch(e){
    print(e);
  }
}