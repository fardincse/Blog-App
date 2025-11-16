import 'dart:convert';
import 'package:blog_app/Model/LogOut/log_out_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

Future logOut() async{
  final baseUrl = dotenv.env['LOGOUT'];
  final box = GetStorage();
  final token = box.read('token');
  try{
    if(baseUrl == null){
      throw Exception('Url not found');
    }
    if(token == null){
      throw Exception('token not found');
    }
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );
    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);
      return LogOutModel.fromJson(decodedData);
    } else{
      throw Exception(response.statusCode);
    }
  } catch(e){
    print('$e');
  }
}