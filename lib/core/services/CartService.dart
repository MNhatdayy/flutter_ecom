import 'dart:convert';
import 'package:flutter_ecom/core/DTO/request/CartRequest.dart';
import 'package:flutter_ecom/core/DTO/response/CartResponse.dart';
import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/services/AuthService.dart';
import 'package:flutter_ecom/core/utils/api/cart.api.dart';


class CartService {
  final BaseClient _baseClient = BaseClient();
  final AuthService _authService = AuthService();

  Future<bool> AddToCart(int productId) async {
    try {
      //lay token tu auth
      final String? token = await _authService.getToken();
      if (token == null) {
        throw Exception('Không tìm thấy token, vui lòng đăng nhập lại.');
      }

      final user = await _authService.getCurrentUser(token);
      final String username = user.username;
      final CartRequest request =
          CartRequest(username: username, productId: productId, quantity: 1);
      final response = await _baseClient.post(
          AppConfig.baseUrl, cardEndpoints().add, request.toJson());
      if (response == null) {
        print('Thêm sản phẩm vào giỏ hàng thành công');
        return true;
      }
      return false;
    } catch (e) {
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }

  Future<bool> RemoveFromCart(int id) async {
    try {
      final response = await _baseClient.delete(
          AppConfig.baseUrl, cardEndpoints().delete + "/$id");
      if (response == null) {
        return true;
      }
      return false;
    } catch (e) {
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }

  Future<List<CartResponse>> GetAllCartItems(String name) async {
    try {
      final response = await _baseClient.get(
          AppConfig.baseUrl, cardEndpoints().getByName + "/$name");
      if (response != null) {
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => CartResponse.fromJson(json)).toList();
      } else {
        throw Exception('No response from server');
      }
    } catch (e) {
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }

  Future<bool> UpdateCart(int cartId, String username, int productId, int quantity) async {
    try {
      final String? token = await _authService.getToken();
      if (token == null) {
        throw Exception('Không tìm thấy token, vui lòng đăng nhập lại.');
      }
      final CartRequest request = CartRequest(
        username: username,
        productId: productId,
        quantity: quantity,
      );

      final response = await _baseClient.put(
        AppConfig.baseUrl,
        cardEndpoints().update + "/$cartId",
        request.toJson(),
      );
      if (response != null) {
        print('Cập nhật giỏ hàng thành công');
        return true;
      } else {
        throw Exception('Lỗi cập nhật giỏ hàng.');
      }
    } catch (e) {
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi khi cập nhật giỏ hàng.');
    }
  }
}
