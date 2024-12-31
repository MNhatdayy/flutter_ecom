import 'package:flutter_ecom/core/DTO/request/auth/LoginRequest.dart';
import 'package:flutter_ecom/core/DTO/request/auth/RegisterRequest.dart';
import 'package:flutter_ecom/core/DTO/response/auth/TokenResponse.dart';
import 'package:flutter_ecom/core/DTO/response/userResponse.dart';

import '../utils/api/auth.api.dart';
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

  Future<UserResponse> getCurrentUser(String? token) async {
    final Map<String, dynamic> payload = {
      'token': token,
    };
    try{
      var response =  await _baseClient.post(AppConfig.baseUrl,authEnpoints().me, payload);
      if (response) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response);
        print(jsonResponse);
        return UserResponse.fromJson(jsonResponse);

      } else {
        throw Exception('Không nhận được phản hồi từ API');
      }
    }catch(e) {
      print('Không thể lấy thông tin $e');
      throw Exception('Không thể lấy thông tin');
    }

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
