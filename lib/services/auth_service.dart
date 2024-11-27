import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:you_app/models/auth_model.dart';

class AuthService {
  final String _baseUrl = 'techtest.youapp.ai';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'accessToken');
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'accessToken');
  }

  Future<AuthLoginModel> login(String email, String username, String password) async {
    final url = Uri.https(_baseUrl, 'api/login');

    try {
      final response = await http.Client().post(
        url,
        body:{
          "email": email.contains('@') ? email : '',
          "username": username.contains('@') ? '' : username,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final auth = AuthLoginModel.fromJson(json);
        await _secureStorage.write(key: 'accessToken', value: auth.accessToken);
        return auth;
      } else {
        // Handle error response
        throw {"error": "Login failed", "status": response.statusCode};
      }
    } catch (error) {
      throw {"error": error.toString()};
    }
  }

  Future<AuthRegisterModel> register(String email, String username, String password) async {
    final url = Uri.https(_baseUrl, 'api/register');

    try {
      final response = await http.Client().post(
        url,
        body:{
          "email": email,
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final auth = AuthRegisterModel.fromJson(json);
        return auth;
      } else {
        // Handle error response
        throw {"error": "Login failed", "status": response.statusCode};
      }
    } catch (error) {
      throw {"error": error.toString()};
    }
  }
}