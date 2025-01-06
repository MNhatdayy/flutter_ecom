import 'dart:convert';
import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/api/product.api.dart';

class ProductService {
  final BaseClient _baseClient = BaseClient();

  Future<List<ProductResponse>> GetAllProducts() async {
    try {
      final response = await _baseClient.get(AppConfig.baseUrl, productEndpoints().getAll);
      if (response != null) {
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => ProductResponse.fromJson(json)).toList();
      } else {
        throw Exception('Không có phản hồi từ server');
      }
    } catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
      throw Exception('lỗi trong quá trình lấy sản phẩm');
    }
  }

  Future<ProductResponse> GetProductById(int id) async {
    try {
      final response = await _baseClient.get(AppConfig.baseUrl, productEndpoints().getById + "/$id");
      if (response != null) {
        return ProductResponse.fromJson(response);
      } else {
        throw Exception('No response from server');
      }
    } catch (e) {
      print('Không thể lấy sản phẩm bằng id $e');
      throw Exception('Không thể lấy sản phẩm bằng ID');
    }
  }
  Future<List<ProductResponse>> GetProductByCategory(int id) async {
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, productEndpoints().getByCategory +"/$id");
      if (response != null) {
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => ProductResponse.fromJson(json)).toList();
      } else {
        throw Exception('No response from server');
      }
    }catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
      throw Exception('lỗi trong quá trình lấy sản phẩm');
    }
  }
  Future<List<ProductResponse>> GetProductByName(String name) async {
    try{
          final response = await _baseClient.get(AppConfig.baseUrl, productEndpoints().getByName+"$name");
      if (response != null) {
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => ProductResponse.fromJson(json)).toList();
      } else {
        throw Exception('No response from server');
      }
    }catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
      throw Exception('lỗi trong quá trình lấy sản phẩm');
    }
  }
}