import 'package:flutter_ecom/core/DTO/request/OrderRequest.dart';
import 'package:flutter_ecom/core/DTO/response/OrderDTO.dart';
import 'package:flutter_ecom/core/DTO/response/OrderResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/services/AuthService.dart';
import 'dart:convert';

import 'package:flutter_ecom/core/utils/api/order.api.dart';
class OrderSerivce {
  final BaseClient _baseClient = BaseClient();
  Future<List<OrderDTO>> GetAllOrderByName(String name) async {
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, orderEndpoints().getmyorder+"/$name");
      if(response != null){
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => OrderDTO.fromJson(json)).toList();
      }else{
        throw Exception('Không có phản hồi từ server');
      }
    }catch (e){
      print('Lỗi khi lấy dữ liệu: $e');
      throw Exception('lỗi trong quá trình lấy dữ liệu');
    }
  }
  Future<OrderResponse> CreateOrder(OrderRequest request) async {
    try{
      final response = await _baseClient.post(AppConfig.baseUrl, orderEndpoints().create, request.toJson());
      if(response != null){
        return OrderResponse.fromJson(response);
      }else {
        throw Exception("No response from server");
      }
    }catch (e) {
      print('Không thể tạo order $e');
      throw Exception('Không thể tạo order');
    }
  }
  Future<String> SubmitOrder(OrderRequest request) async {
      final response = await _baseClient.post(AppConfig.baseUrl, orderEndpoints().submit, request.toJson());
      if (response == null && response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("No valid response or Bad Request from server");
      }

  }
}