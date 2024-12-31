import 'package:flutter_ecom/core/DTO/request/OrderRequest.dart';
import 'package:flutter_ecom/core/DTO/response/OrderResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'dart:convert';

import 'package:flutter_ecom/core/utils/api/order.api.dart';
class OrderSerivce {
  final BaseClient _baseClient = BaseClient();
  Future<List<OrderResponse>> GetAllOrderByName(String name) async {
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, orderEndpoints().getmyorder+"/$name");
      if(response){
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => OrderResponse.fromJson(json)).toList();
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
      final response = await _baseClient.post(AppConfig.baseUrl, orderEndpoints().create, request);
      if(response){
        return OrderResponse.fromJson(response);
      }else {
        throw Exception("No response from server");
      }
    }catch (e) {
      print('Không thể tạo order $e');
      throw Exception('Không thể tạo order');
    }
  }
  Future<String> SubmitOrder(OrderRequest request) async{
    try{
      final response = await _baseClient.post(AppConfig.baseUrl, orderEndpoints().submit, request);
      if(response){
        return response;
      }else {
        throw Exception("No response from server");
      }
    }catch (e) {
      print('Không thể tạo order $e');
      throw Exception('Không thể tạo order');
    }
  }
}