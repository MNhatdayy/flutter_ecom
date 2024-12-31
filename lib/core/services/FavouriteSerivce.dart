import 'dart:convert';
import 'package:flutter_ecom/core/DTO/request/FavouriteRequest.dart';
import 'package:flutter_ecom/core/DTO/response/FavouriteResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/api/favourite.api.dart';
class FavouriteService{
  final BaseClient _baseClient = BaseClient();
  Future<bool> FavouriteProduct(FavouriteRequest request) async {
    try{
      final response = await _baseClient.post(AppConfig.baseUrl, favouriteEnpoints().like, request);
    if(response){
        return true;
    }
    return false;
    }catch (e){
      print('Lỗi khi xử lý: $e');
      throw Exception('Lỗi');
    }
  }
  Future<bool> UnlikeProduct(FavouriteRequest request) async {
    try{
      final response = await _baseClient.post(AppConfig.baseUrl, favouriteEnpoints().unlike, request);
      if(response){
        return true;
      }
      return false;
    }catch (e){
      print(e);
      throw Exception('Lỗi');
    }
  }
  Future<FavoriteResponse> GetFavouriteProduct(String name) async {
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, favouriteEnpoints().get+ "/$name");
      if(response){
        final Map<String, dynamic> jsonResponse = jsonDecode(response);
        return FavoriteResponse.fromJson(jsonResponse);
      }else{
        throw Exception('Không nhận được phản hồi từ API');
      }
    }catch (e){
      print(e);
      throw Exception('Lỗi trong quá trình lấy sản phẩm ưa thích');
    }
  }
}