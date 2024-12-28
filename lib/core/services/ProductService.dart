import 'dart:convert';
import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/product.api.dart';

class ProductService {
  final BaseClient _baseClient = BaseClient();

  Future<List<ProductResponse>> GetAllProducts() async {
    try {
      final response = await _baseClient.get(AppConfig.baseUrl, productEndpoints().getAll);
      if (response != null) {
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => ProductResponse.fromJson(json)).toList();
      } else {
        throw Exception('No response from server');
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
      print('Error fetching product by ID: $e');
      throw Exception('Error fetching product by ID');
    }
  }

}