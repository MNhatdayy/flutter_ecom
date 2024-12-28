import 'dart:convert';

import 'package:flutter_ecom/core/DTO/response/CategoryResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/category.api.dart';

import '../config/config.dart';

class CategoryService {
  final BaseClient _baseClient = BaseClient();
  Future<List<CategoryResponse>> GetAllCategory() async{
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, categoryEndpoints().getAll);
      if(response != null ){
        final List<dynamic> jsonResponse = jsonDecode(response);
        return jsonResponse.map((json) => CategoryResponse.fromJson(json)).toList();
      }else{
        throw Exception('Không nhận được phản hồi từ server');
      }
    }catch (e){
      print('Lỗi khi lấy danh mục: $e');
      throw Exception('Lỗi trong quá trình lấy danh mục');
    }
  }
  Future<CategoryResponse> GetCategoryById(int id) async{
    try{
      final response = await _baseClient.get(AppConfig.baseUrl, categoryEndpoints().getById+"/$id");
      if(response != null ){
        return CategoryResponse.fromJson(response);
      }else{
        throw Exception('Không nhận được phản hồi từ server');
      }
    }catch (e){
      print('Lỗi khi lấy danh mục: $e');
      throw Exception('Lỗi trong quá trình lấy danh mục');
    }
  }
}