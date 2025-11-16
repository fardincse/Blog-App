import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future deleteComment(int commentId) async{
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

    final response = await http.delete(
      Uri.parse('$baseUrl$commentId'),
      headers: <String, String>{
        'Content-Type' : 'applicatino/json',
        'Authorization' : 'Bearer $token'
      }
    );
    if(response.statusCode == 200){
      return "Comment delete sucessfull";
    } else{
      return "Somthing went wrong";
    }
  }catch(e){
    return e;
  }
}