import '../utils/auth.api.dart';
import '../config/base_client.dart';
import '../config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class AuthService {
  final BaseClient _baseClient = BaseClient();

  Future<dynamic> login(String username, String password) async {
    final Map<String, dynamic> payload = {
      'username': username,
      'password': password,
    };
    final response = await _baseClient.post(AppConfig.baseUrl,authEnpoints().login ,payload);
    if (response != null) {
      try {
        // Chuyển đổi dữ liệu trả về nếu cần thiết (nếu là chuỗi JSON)
        final Map<String, dynamic> jsonResponse = jsonDecode(response);

        // Kiểm tra xem token có trong response hay không
        if (jsonResponse.containsKey('token')) {
          return jsonResponse['token']; // Hoặc trả về toàn bộ dữ liệu nếu cần
        } else {
          throw Exception('Token không có trong phản hồi');
        }
      } catch (e) {
        print('Lỗi khi xử lý dữ liệu JSON: $e');
        throw Exception('Dữ liệu trả về không hợp lệ');
      }
    } else {
      throw Exception('Không nhận được phản hồi từ API');
    }
  }

  // Đăng ký
  Future<dynamic> register(String username, String email, String password) async {
    final Map<String, dynamic> payload = {
      'username': username,
      'email': email,
      'password': password,
    };
    return await _baseClient.post(AppConfig.baseUrl,authEnpoints().register, payload);
  }


  Future<void> logout() async {
    try {
      await _baseClient.post(AppConfig.baseUrl,authEnpoints().register, {});
    } catch (e) {
      rethrow;
    }
  }

  // Future<dynamic> getCurrentUser() async {
  //   return await _apiService.get('/auth/me');
  // }

  // Lưu token vào bộ nhớ (ví dụ: SharedPreferences hoặc SecureStorage)
  Future<void> saveToken(String token) async {
    // Sử dụng SharedPreferences để lưu token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Lấy token từ bộ nhớ
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Xóa token khỏi bộ nhớ
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
