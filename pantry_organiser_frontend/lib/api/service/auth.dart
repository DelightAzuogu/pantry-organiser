import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

class AuthApi {
  AuthApi(this._apiService);

  final ApiService _apiService;

  final String _authUrl = 'auth';

  Future<LoginModel> login(String email, String password) async {
    try {
      final body = json.encode({
        'email': email,
        'password': password,
      });

      final response = await _apiService.post(
        '$_authUrl/login',
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        return LoginModel.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to login');
  }

  Future<LoginModel> register(String email, String password) async {
    try {
      final body = json.encode({
        'email': email,
        'password': password,
      });

      final response = await _apiService.post(
        '$_authUrl/register',
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        return LoginModel.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to register');
  }
}
