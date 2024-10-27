import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = ''; 

  Future<Map<String, dynamic>> signIn(String mail, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'mail': mail,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el inicio de sesión');
    }
  }

  Future<Map<String, dynamic>> registerBrigade(String mail, String password, Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/register/brigade');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'mail': mail,
        'password': password,
        'user': userData,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el registro de brigadista');
    }
  }

  Future<Map<String, dynamic>> registerUpbCommunity(String mail, String password, Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/register/upb-community');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'mail': mail,
        'password': password,
        'user': userData,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el registro de usuario de UPB');
    }
  }

  Future<Map<String, dynamic>> registerAPH(String mail, String password, Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/register/prehospital-care');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'mail': mail,
        'password': password,
        'user': userData,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el registro de APH');
    }
  }
}
