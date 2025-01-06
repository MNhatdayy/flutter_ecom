import 'dart:convert';
import 'package:flutter_ecom/core/DTO/response/OrderDetailResponse.dart';
import 'package:flutter_ecom/core/DTO/response/OrderResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/api/orderdetail.api.dart';
class OrderDetailService {
  final BaseClient _baseClient = BaseClient();
  Future<List<OrderDetailResponse>> GetAllOrderProducts(int id) async {
    try {
      final response = await _baseClient.get(AppConfig.baseUrl, orderDetailEndpoints().getById+"/$id");
      if (response != null) {

        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => OrderDetailResponse.fromJson(json)).toList();
      } else {
        throw Exception('Không có phản hồi từ server');
      }
    } catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
      throw Exception('lỗi trong quá trình lấy sản phẩm');
    }
  }
}