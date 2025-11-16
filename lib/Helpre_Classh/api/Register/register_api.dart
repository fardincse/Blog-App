import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:blog_app/Model/Register_Model/register.dart';

Future postRegister(RegisterModel model) async {
  final registerApi = dotenv.env['REGURL'];
  if (registerApi == null) {
    throw Exception('API URL is null! Check your .env file and key.');
  }
  try {
    final response = await http.post(
      Uri.parse(registerApi),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        "name": model.name,
        "email": model.email,
        "password": model.password,
        "phone": model.phone,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return FromRegister.fromJson(data);
    } else {
      final data = jsonDecode(response.body);
      return FromRegister.fromJson(data);
    }
  } catch (e) {
    print(e);
  }
}
