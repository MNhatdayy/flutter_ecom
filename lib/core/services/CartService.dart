import 'dart:convert';
import 'package:flutter_ecom/core/DTO/request/CartRequest.dart';
import 'package:flutter_ecom/core/DTO/response/CartResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/api/cart.api.dart';
class CartService {
  final BaseClient _baseClient = BaseClient();
  Future<bool> AddToCart(CartRequest request) async{
    try{
      final response = await _baseClient.post(AppConfig.baseUrl, cardEndpoints().add, request);
      if(response){
        return true;
      }
      return false;
    }catch (e){
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }
  Future<bool> RemoveFromCart(CartRequest request) async{
    try{
      final response = await _baseClient.post(AppConfig.baseUrl, cardEndpoints().delete, request);
      if(response){
        return true;
      }
      return false;
    }catch (e){
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }
  Future<List<CartResponse>> GetAllCartItems(String name) async {
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, cardEndpoints().getByName+"/$name");
      if(response){
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => CartResponse.fromJson(json)).toList();
      }else{
        throw Exception('No response from server');
      }
    }catch (e){
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }
}