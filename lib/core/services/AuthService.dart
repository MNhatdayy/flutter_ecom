import 'package:flutter_ecom/core/DTO/request/auth/LoginRequest.dart';
import 'package:flutter_ecom/core/DTO/request/auth/RegisterRequest.dart';
import 'package:flutter_ecom/core/DTO/response/auth/TokenResponse.dart';

import '../utils/auth.api.dart';
import '../config/base_client.dart';
import '../config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class AuthService {
  final BaseClient _baseClient = BaseClient();

  Future<TokenResponse> login(LoginRequest request) async {
    try {
      final response = await _baseClient.post(
        AppConfig.baseUrl,
        authEnpoints().login,
        request.toJson(),
      );
      if (response != null) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response);

        if (jsonResponse.containsKey('token')) {
          return TokenResponse.fromJson(jsonResponse);
        } else {
          throw Exception('Token không có trong phản hồi');
        }
      } else {
        throw Exception('Không nhận được phản hồi từ API');
      }
    } catch (e) {
      print('Lỗi khi xử lý login: $e');
      throw Exception('Lỗi trong quá trình đăng nhập');
    }
  }

  Future<dynamic> register(RegisterRequest request) async {
    return await _baseClient.post(AppConfig.baseUrl,authEnpoints().register, request.toJson());
  }


  Future<void> logout() async {
    try {
      await _baseClient.post(AppConfig.baseUrl,authEnpoints().logout, {});
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getCurrentUser(String token) async {
    final Map<String, dynamic> payload = {
      'token': token,
    };
    return await _baseClient.getPayload(AppConfig.baseUrl,authEnpoints().me, payload);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }


  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }


  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
