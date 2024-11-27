
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:you_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'techtest.youapp.ai';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'accessToken');
  }

  Future<UserModel> getProfile() async {
    final url = Uri.https(_baseUrl, 'api/getProfile');

    try {
      final accessToken = await getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        final response = await http.Client().get(
          url,
          headers: {
            'accept': '*/*',
            'x-access-token': accessToken,
          }
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          return UserModel.fromJson(jsonData);
        } else {
          throw Exception(
              'Failed to load profile: ${response.statusCode} ${response.body}');
        }
      } else {
        throw Exception('Access token is missing or invalid.');
      }
    } catch (e) {
      throw {"error": e.toString()};
    }
  }

  Future<UserModel> updateProfile(String name, String birthday, String height, String weight, List<String> interests) async {
    final url = Uri.https(_baseUrl, 'api/updateProfile');
    print('hai');
    try {
      final accessToken = await getAccessToken();
      print(jsonEncode({
            "name": name,
            "birthday": birthday,
            "height": int.parse(height),
            "weight": int.parse(weight),
            "interests": interests
          }));
      if (accessToken != null && accessToken.isNotEmpty) {
        final response = await http.Client().put(
          url,
          headers: {
            'accept': '*/*',
            'x-access-token': accessToken,
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "name": name,
            "birthday": birthday,
            "height": int.parse(height),
            "weight": int.parse(weight),
            "interests": interests
          })
        );
        print(jsonDecode(response.body));
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          return UserModel.fromJson(jsonData);
        } else {
          throw {"error": 'Failed to update profile: ${response.statusCode} ${response.body}'};
        }
      } else {
        throw {'error': 'Access token is missing or invalid.'};
      }
    } catch (e) {
      print(e.toString());
      throw {"error": e.toString()};
    }
  }
}
